
var config = {

   repo: 'WildDoogyPlumb/StarCharts',

   weekDaysOff: [0,6],

   colorByDev: {
      "neyric": "ganttBlue",
      "unassigned": "ganttRed"
   },

   holidays: {
      "neyric": [
         { start: new Date(2014, 0, 1), end: new Date(2014, 0, 11), title: 'Déménagement'}
      ]
   },


   excludedMilestones: [
      "Feature Paradize"
   ],

   defaultDuration: 1 // in days

};
