sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'projecttemplate/test/integration/FirstJourney',
		'projecttemplate/test/integration/pages/GetTemplateList',
		'projecttemplate/test/integration/pages/GetTemplateObjectPage'
    ],
    function(JourneyRunner, opaJourney, GetTemplateList, GetTemplateObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('projecttemplate') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheGetTemplateList: GetTemplateList,
					onTheGetTemplateObjectPage: GetTemplateObjectPage
                }
            },
            opaJourney.run
        );
    }
);