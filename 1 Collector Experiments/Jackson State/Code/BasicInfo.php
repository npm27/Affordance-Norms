<?php
/*  Collector
    A program for running experiments on the web
    Copyright 2012-2015 Mikey Garcia & Nate Kornell
 */
    require 'initiateCollector.php';
    
    $title = 'Basic Information';
    require $_PATH->get('Header');
?>
<style>    
    #content {
        width:auto;
        min-width: 400px;
        /*Make the flexchild, form, fit the basic info content size*/
    }
</style>
<form id="content" class="basicInfo" name="Demographics"
      action="<?= $_PATH->get('Basic Info Record') ?>" method="post" autocomplete="off">
    
    <fieldset>
        <legend><h1>Basic Information</h1></legend>
        
        
        <section class="radioButtons">
            <h3>Gender</h3>
            <label><input name="Gender" type="radio" value="Male"   required/>Male</label>
            <label><input name="Gender" type="radio" value="Female" required/>Female</label>
            <label><input name="Gender" type="radio" value="Other"  required/>Other</label>
        </section>
        
        
        <section>
            <label>
                <h3>Age</h3>
                <input name="Age" class="wide collectorInput" type="text"
                pattern="[0-9][0-9]" value="" autocomplete="off" required/>
            </label>
        </section>
        
        
        <section>
            <label>
                <h3>Education</h3>
                <select name="Education" class="wide collectorInput" required>
                    <option value="" default selected>Select Level</option>
                    <option>Some High School</option>
                    <option>High School Graduate</option>
                    <option>Some College, no degree</option>
                    <option>Associates degree</option>
                    <option>Bachelors degree</option>
                    <option>Graduate degree (Masters, Doctorate, etc.)</option>
                </select>
            </label>
        </section>
        
        
        <!-- <section class="radioButtons">
            <h3>Are you Hispanic?</h3>
            <label><input name="Hispanic" type="radio" value="Yes"   required/>Yes</label>
            <label><input name="Hispanic" type="radio" value="No"    required/>No</label>
        </section> -->
        
        
        <section>
            <label>
                <h3>Ethnicity</h3>
                <select name="Race" required class="wide collectorInput">
                    <option value="" default selected>Select one</option>
                    <option>American Indian/Alaskan Native</option>
                    <option>Asian/Pacific Islander</option>
                    <option>Black</option>
                    <option>White</option>
                    <option>Other/unknown</option>
                </select>
            </label>
        </section>
        
        
        <section class="radioButtons">
            <h3>Do you speak english fluently?</h3>
            <label><input name="Fluent" type="radio" value="Yes"   required/>Yes</label>
            <label><input name="Fluent" type="radio" value="No"    required/>No</label>
        </section>
        
        
        <section>
            <label>
                <h3>At what age did you start learning English?</h3>
                <input name="AgeEnglish" type="text" value="" autocomplete="off" class="wide collectorInput"/>
                <div class="small shim">If English is your first language please enter 0.</div>
            </label>
        </section>
        
        
        <section>
            <label>
                <h3>What is your country of residence?</h3>
                <input name="Country" type="text" value="" autocomplete="off" class="wide collectorInput"/>
            </label>
        </section>
        
        
        <section class="consent">
            <legend><h3>Informed Consent</h3></legend>
            <textarea readonly>The purpose of this study is to understand how individuals perceive and understand objects based on object use. Objects differ in the number of action possibilities (termed affordances), and our study will provide an assessment of different object affordances and how frequently an affordance is listed for a given object. In this study, you will be presented with a set of 30 objects. Your task will be to list as many possible actions for each object. The experiment will take approximately 30 minutes to complete and you will receive .5 credits toward your Introduction to Psychology course for your participation. The researchers do not expect any risks from participating in this study other than the possibility of slight boredom during task completion. Your participation will be kept confidential. You are free to discontinue at anytime. Your data will be deleted immediately after you withdraw. This project and the consent form have been reviewed by the Instituional Review Board at Jackson State University. If you have any concerns regarding this study or questions about your rights as a resarch participant, you may contact the office of research compliance (irb@jsums.edu). General questions about your participation today should be directed to the principle investigator, Dr. Kendal Smith (kendal.a.smith@jsums.edu)</textarea>
            <label>
                <span class="shim">Check this box if you have read, understand, 
                    and agree to the Informed Consent above.</span>
                <input type="checkbox" name="consent" required/>
            </label>
        </section>
        
        
        <section>
            <button class="collectorButton">Submit Basic Info</button>
        </section>
        
    </fieldset>
</form>

<?php
    require $_PATH->get('Footer');
