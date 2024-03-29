.timepoints[] as $timepoint | $timepoint.samples[]? as $sample  | 
{ atlasParticipantId : .atlasParticipantId, 
  atlasGroup : .atlasGroup, 
  sex: .sex,
  race: .race,
  ethnicity: .ethnicity,
  ageAtMenarche: .ageAtMenarche,
  classBRCA1: .classBRCA1,
  classBRCA2: .classBRCA2,
  timepointLabel : $timepoint.timepointLabel,
  age: $timepoint.age,
  weight: $timepoint.weight,
  menopauseStatus: $timepoint.menopauseStatus,
  menopauseCycleStage: $timepoint.menopauseCycleStage,
  gravidity : $timepoint.gravidity,
  parity : $timepoint.parity,
  primaryDiagnosis : $timepoint.primaryDiagnosis,
  previousDiagnosis : $timepoint.previousDiagnosis,
  tobaccoUse : $timepoint.tobaccoUse,
  packYearsSmoked : $timepoint.packYearsSmoked,
  alcoholUse : $timepoint.alcoholUse,
  drinksPerWeek : $timepoint.drinksPerWeek,
  antibioticUse : $timepoint.antibioticUse,
  sampleId : $sample.sampleId,
  sampleCollectionCenter : $sample.sampleCollectionCenter,
  sampleSite: $sample.sampleSite,
  tumorGrade : $sample.tumorGrade,
  statusER : $sample.statusER,
  statusPR : $sample.statusPR,
  statusHER2 : $sample.statusHER2,
  synData : $sample.synData
    
} 
