<?php
    if (!isset($text) || $text === '') { 
        $text = 'Please name all of the ways you could use this object. Keep in mind that one object can have many uses. Separate your responses with a comma.';
    }

    $texts = explode('|', $text);
    $mainText = array_shift($texts);
?>

<div class="textcenter">
    <div><?php echo isset($text) ? $text : ""; ?></div>

<br>

<div class="study">

    <?php echo $cue;     ?>

    <br>

<br>
  
<div class="textcenter">
    <input name="JOL" type="text" value="" autocomplete="off" class="textcenter collectorInput">
    <button class="collectorButton" id="FormSubmitButton">Submit</button>
</div>
