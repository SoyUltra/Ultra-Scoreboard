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

        break;

        case "show":
            $('.allscore').show(300)
        break;

        case "hide":
            $('.allscore').hide(300)
        break;
    }
});


//EXIT//

document.addEventListener('keydown', this.exitKey)

function exitKey(event) {
            
    if (event.keyCode==27 || event.keyCode==8 || event.keyCode == 36)
    
    {
        $.post("https://Ultra-Scoreboard/exit", JSON.stringify({}))
    }
}

