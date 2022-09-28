var robberyshow = false;
window.addEventListener("message", function(event) {
    var v = event.data
    let bank = event.data.bank;

    switch (v.action) {

        case "updatedata":
            $('.logoconfig').attr('src', v.logo);
            $('.job').text('Job: '+v.job);
            $('.name').text('Name: '+v.name);
            $('.phone').text('Phone: '+v.phone);
            $('.id').html('ID: '+v.pid);
            $('.bank').text('Bank: '+bank);
            $('.playersonline').html('<i class="fas fa-user"></i> Players:'+v.playerss+"/"+v.maxPlayers+'');
        break;

        case "updatedatajob":
            $('.jdat1').text(v.mechanic);
            $('.jdat2').text(v.police);
            $('.jdat3').text(v.ambulance);
            $('.jdat4').text(v.realestate);
            $('.jdat5').text(v.taxi);
            $('.jdat6').text(v.abogado);
            canRob(v.police,v.robos);
        break;

        case "show":
            $('.allscore').show(300)
        break;

        case "hide":
            $('.allscore').hide(300)
            $('.robbery').hide(300)
        break;

        case "bottom":
            $("#robberybottom").click(function (e) {
                e.stopImmediatePropagation();
                if ( robberyshow == false )
                {
                    $('.robbery').show(300)
                    robberyshow = true;
                }else{
                    $('.robbery').hide(300)
                    robberyshow = false;
                }
                
            });
        break;

        case "showrobbery":
            $('.planelrobberyalll').show(300)
        break;
    }
});

//EXIT//

document.addEventListener('keydown', this.exitKey)

function exitKey(event) {
            
    if (event.keyCode==27 || event.keyCode==8)
    
    {
        $.post("https://Ultra-Scoreboard/exit", JSON.stringify({}))
        $('.robbery').hide(300)
    }
}


function canRob(polices,robs)
    
    {
    if(robs[0].requieredCops==polices){
        $('.rdat1').text('✓');
    }
    else{
        $('.rdat1').text('✘');
    }
    if(robs[1].requieredCops==polices){
        $('.rdat2').text('✓');
    }
    else{
        $('.rdat2').text('✘');
    }
    if(robs[2].requieredCops==polices){
        $('.rdat3').text('✓');
    }
    else{
        $('.rdat3').text('✘');
    }
    if(robs[3].requieredCops==polices){
        $('.rdat4').text('✓');
    }
    else{
        $('.rdat4').text('✘');
    }
    if(robs[4].requieredCops==polices){
        $('.rdat5').text('✓');
    }
    else{
        $('.rdat5').text('✘');
    }
    if(robs[5].requieredCops==polices){
        $('.rdat6').text('✓');
    }
    else{
        $('.rdat6').text('✘');
    }
    if(robs[6].requieredCops==polices){
        $('.rdat7').text('✓');
    }
    else{
        $('.rdat7').text('✘');
    }
    if(robs[7].requieredCops == polices){
        $('.rdat8').text('✓');
    }
    else{
        $('.rdat8').text('✘');
    }
    if(robs[8].requieredCops == polices){
        $('.rdat9').text('✓');
    }
    else{
        $('.rdat9').text('✘');
    }
}



