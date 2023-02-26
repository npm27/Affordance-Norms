<?php
/*  Collector
    A program for running experiments on the web
    Copyright 2012-2015 Mikey Garcia & Nate Kornell
 */
    require 'initiateCollector.php';
    
    #### this code was causing more problems than it is solving
    # Need to think of a better anti-cheat mode but for now we are skipping any done.php check
    // if someone skipped to done.php without doing all trials
    // if ((array_key_exists('finishedTrials', $_SESSION) == false)
    //     OR ($_SESSION['finishedTrials'] != true)
    // ) {
    //     header("Location: http://www.youtube.com/watch?v=oHg5SJYRHA0");            // rick roll people trying to skip to done.php
    //     exit;
    // }
    
    
    // turn off error reporting for debug mode
    if (array_key_exists('Debug', $_SESSION)) {
        if ($_SESSION['Debug'] == false) {
            error_reporting(0);
        }
    }
    
    
    // Set the page message
    if ($_CONFIG->next_experiment == false) {
        $title   = 'Done!';
        $message = '<h2>Thank you for your participation! Please make note right now of the exact time/date you completed this study. You will will need this information to claim your credit!</h2>'
		 .  '<p>To receive your credit, please click on the following link or copy it into a new browser tab:</p>'
		 .  '<a href="https://www.surveymonkey.com/r/PsychResearchSpring2023">https://www.surveymonkey.com/r/PsychResearchSpring2023</a>'
                 .  '<p>You will be asked to provide your name, indicate the study you just completed, and indicate the course in which you want research credit. You will also be asked for the time/date in which you began AND finished the study.'
                 .  '</p>';
        if ($_CONFIG->mTurk_mode == true) {
            $message .= '<h3>Your verification code is: ' . $_CONFIG->verification . '-' . $_SESSION['ID'] .'</h3>';
        }
    } else {
        $title    = 'Quick Break';
        $message  = '<h2>Experiment will resume in 5 seconds.</h2>';
        $nextLink = 'http://' . $_CONFIG->next_experiment;
        $username = $_SESSION['Debug'] ? $_CONFIG->debug_name . ' ' . $_SESSION['Username'] : $_SESSION['Username'];
        echo '<meta http-equiv="refresh" content="5; url=' . $nextLink . 'Code/login.php?Username='
            . urlencode($username) . '&Condition=Auto&ID=' . $_SESSION['ID'] . '">';
    }
    
    
    if (isset($_SESSION['finishedTrials'])
        AND (!isset($_SESSION['alreadyDone']))
        ) {
        // calculate total duration of experiment session
        $duration = time() - strtotime($_SESSION['Start Time']);
        $durationFormatted = $duration;
        $hours   = floor($durationFormatted/3600);
        $minutes = floor( ($durationFormatted - $hours*3600)/60);
        $seconds = $durationFormatted - $hours*3600 - $minutes*60;
        if ($hours   < 10 ) { $hours   = '0' . $hours;   }
        if ($minutes < 10 ) { $minutes = '0' . $minutes; }
        if ($seconds < 10 ) { $seconds = '0' . $seconds; }
        $durationFormatted = $hours . ':' . $minutes . ':' . $seconds;
        
        
        #### Record info about the person ending the experiment to status finish file
        $data = array(
                        'Username'              => $_SESSION['Username'],
                        'ID'                    => $_SESSION['ID'],
                        'Date'                  => date('c'),
                        'Duration'              => $duration,
                        
                        'Duration_Formatted'    => $durationFormatted,
                        'Session'               => $_SESSION['Session'],
                        'Condition_Number'      => $_SESSION['Condition']['Number'],
                        );
        arrayToLine($data, $_PATH->get('Status End Data'));
        
        
        ######## Save the $_SESSION array as a JSON string
        $ExpOverFlag = $_SESSION['Trials'][ ($_SESSION['Position']) ]['Procedure']['Item'];
        // if you haven't finished all sessions yet
        if ($ExpOverFlag != 'ExperimentFinished') {           
            $_SESSION['Position']++;                        // increment counter so next session will begin after the *NewSession* (if multisession)
            $_SESSION['Session']++;                         // increment session # so next login will be correctly labeled as the next session
            $_SESSION['ID'] = rand_string();                // generate a new ID (for next login)
            $_SESSION['finishedTrials'] = false;            // will stop them from skipping to done.php during next session
            $_SESSION['LastFinish'] = time();
        }
        
        $jsonSession = json_encode($_SESSION);              // encode the entire $_SESSION array as a json string
        $jsonPath = $_PATH->get('json');
        
        if (!is_dir($_PATH->get('JSON Dir'))) {
            // make the folder if it doesn't exist
            mkdir($_PATH->get('JSON Dir'), 0777, true);
        }
        file_put_contents($jsonPath, $jsonSession);
        #######
    }
    
        
    require $_PATH->get('Header');
?>
    <form id="content">
        <?php echo $message; ?>
    </form>
    
    <style>
        #content {
            width: 500px;
            text-rendering: optimizeLegibility;
        }
    </style>
<?php
    require $_PATH->get('Footer');
?>
