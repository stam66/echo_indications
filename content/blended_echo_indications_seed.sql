-- ============================================================================
-- Blended adult echocardiography AUC seed content
-- ============================================================================
-- DRAFT FOR CLINICAL REVIEW. This file paraphrases and merges common adult TTE
-- indications from BSE, BHVS, EACVI and ASE/ACC AUC material. It is intended to
-- replace or update matching records by title, then link contexts by name.
--
-- Source-PDF verification pass on 2026-05-20 incorporated content from the
-- 2011 ACCF/ASE AUC, the 2017 ACC/AHA/ASE VHD AUC, the 2019 ACC/AHA/ASE
-- nonvalvular AUC and the 2024 BSE/PCCS primary-care triage poster (PUE014).
-- See `blended_echo_auc_sources.md` for the full source list and the mapping
-- between ASE/ACC numeric scores and the verdict enum used here.
--
-- Prerequisite:
--   migrations/2026-05-19_add_bhvs_source.sql
-- ============================================================================

START TRANSACTION;

INSERT INTO contexts (name, description, sort_order, is_active)
SELECT v.name, v.description, v.sort_order, 1
FROM (
  SELECT 'Chest pain' name, 'Chest pain and acute coronary presentations' description, 10 sort_order UNION ALL
  SELECT 'Heart failure', 'Suspected or established heart failure and LV dysfunction', 20 UNION ALL
  SELECT 'Valve disease', 'Native valve stenosis or regurgitation', 30 UNION ALL
  SELECT 'Prosthetic valve', 'Valve replacement, valve repair and transcatheter valve follow-up', 40 UNION ALL
  SELECT 'Murmur', 'Clinical murmur assessment', 50 UNION ALL
  SELECT 'Arrhythmia', 'Atrial and ventricular rhythm disorders', 60 UNION ALL
  SELECT 'Syncope', 'Syncope and presyncope', 70 UNION ALL
  SELECT 'Pulmonary disease', 'Pulmonary hypertension, pulmonary embolus and right heart disease', 80 UNION ALL
  SELECT 'Pericardial disease', 'Pericarditis, effusion, constriction and tamponade', 90 UNION ALL
  SELECT 'Endocarditis', 'Suspected or treated infective endocarditis', 100 UNION ALL
  SELECT 'Cardiomyopathy', 'Known or suspected cardiomyopathy', 110 UNION ALL
  SELECT 'Hypertension/LVH', 'Hypertension, LVH and coarctation questions', 120 UNION ALL
  SELECT 'Aortopathy', 'Aortic root, ascending aorta and inherited aortopathy', 130 UNION ALL
  SELECT 'Stroke/TIA/embolism', 'Systemic embolism, stroke, TIA and suspected cardiac mass', 140 UNION ALL
  SELECT 'Pre-operative', 'Non-cardiac surgery assessment', 150 UNION ALL
  SELECT 'Post-procedure', 'Post cardiac operation or structural intervention', 160 UNION ALL
  SELECT 'Cardio-oncology', 'Potentially cardiotoxic cancer therapy', 170 UNION ALL
  SELECT 'Critical care', 'Shock, fluid balance, ventilation and organ-support decisions', 180 UNION ALL
  SELECT 'Congenital/inherited', 'Adult congenital or inherited cardiovascular conditions', 190
) v
WHERE NOT EXISTS (SELECT 1 FROM contexts c WHERE c.name = v.name);

DROP TEMPORARY TABLE IF EXISTS import_blended_indications;
CREATE TEMPORARY TABLE import_blended_indications (
  title TEXT NOT NULL,
  keywords TEXT,
  comments TEXT,
  primary_care ENUM('indicated','not_indicated','can_be_considered') NOT NULL,
  secondary_inpatient ENUM('indicated','not_indicated','can_be_considered') NOT NULL,
  secondary_outpatient ENUM('indicated','not_indicated','can_be_considered') NOT NULL,
  source_ase TINYINT(1) NOT NULL DEFAULT 0,
  source_eacvi TINYINT(1) NOT NULL DEFAULT 0,
  source_bse TINYINT(1) NOT NULL DEFAULT 0,
  source_bhvs TINYINT(1) NOT NULL DEFAULT 0,
  source_consensus TINYINT(1) NOT NULL DEFAULT 0,
  urgency ENUM('not_indicated','can_be_considered','routine','soon','urgent') NOT NULL DEFAULT 'routine',
  contexts TEXT NOT NULL
);

INSERT INTO import_blended_indications
(title, keywords, comments, primary_care, secondary_inpatient, secondary_outpatient, source_ase, source_eacvi, source_bse, source_bhvs, source_consensus, urgency, contexts)
VALUES
('Innocent murmur confidently diagnosed by a physician',
 'innocent murmur;flow murmur;soft systolic murmur;normal S2;pregnancy murmur',
 'Merged concept: BSE classifies a clinically innocent murmur as low value for TTE unless features suggest structural disease. Use judgement if examination quality is uncertain.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Murmur;Valve disease'),
('Unchanged murmur with previous normal echocardiogram and no symptoms',
 'unchanged murmur;previous normal echo;asymptomatic murmur;repeat echo',
 'Merged BSE/ASE concept: repeating TTE is usually low value when the murmur is unchanged, the patient is asymptomatic and prior imaging was normal.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Murmur;Valve disease'),
('Murmur with cardiac or respiratory symptoms',
 'murmur dyspnoea;murmur breathlessness;murmur chest pain;symptomatic murmur',
 'Appropriate when symptoms raise suspicion of structural or haemodynamic valve disease. BHVS/BSE valve guidance should determine follow-up once severity is known.',
 'indicated','indicated','indicated',1,1,1,1,0,'routine','Murmur;Valve disease'),
('Murmur with syncope or advanced heart failure symptoms',
 'murmur syncope;NYHA III;NYHA IV;class 3 heart failure;class 4 heart failure;severe valve disease',
 'High-priority murmur scenario because severe valve disease or obstructive physiology may change urgent management.',
 'indicated','indicated','indicated',1,1,1,1,0,'urgent','Murmur;Valve disease;Syncope;Heart failure'),
('Asymptomatic murmur with clinical features suggesting structural heart disease',
 'murmur abnormal ECG;thrill;radiation;diastolic murmur;structural heart disease',
 'Appropriate where examination or other testing suggests valve or structural disease even without symptoms.',
 'indicated','indicated','indicated',1,1,1,1,0,'routine','Murmur;Valve disease'),
('Suspected heart failure with clinical signs',
 'heart failure;HF;peripheral oedema;bilateral pleural effusions;raised JVP;fluid overload',
 'Appropriate for suspected HF when signs or objective findings make cardiac dysfunction plausible.',
 'indicated','indicated','indicated',1,0,1,0,0,'soon','Heart failure'),
('Suspected heart failure with high natriuretic peptide',
 'NT-proBNP;BNP;raised BNP;NICE heart failure;new HF;breathlessness',
 'BSE PUE014 and NICE NG106 expedite by natriuretic peptide: NT-proBNP >2000 ng/L triggers specialist review and TTE within two weeks, 400-2000 ng/L within six weeks, <400 ng/L makes HF unlikely. Threshold-specific rows capture each band.',
 'indicated','indicated','indicated',1,0,1,0,0,'urgent','Heart failure'),
('Peripheral oedema without cardiac signs, normal JVP and no cardiac abnormality',
 'ankle swelling;peripheral oedema;normal JVP;normal ECG;no cardiac disease',
 'Low-yield referral pattern in BSE triage when there is no clinical or ECG evidence of cardiac disease.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Heart failure'),
('Radiographic cardiomegaly without heart failure symptoms or supporting clinical information',
 'cardiomegaly;CXR enlarged heart;incidental cardiomegaly;no symptoms',
 'BSE PUE014 explicitly lists incidental CXR cardiomegaly with a normal 12-lead ECG, normal cardiovascular examination and normal BNP/NT-proBNP as low yield in primary care. Use advice and guidance pathways before requesting TTE.',
 'not_indicated','can_be_considered','not_indicated',1,0,1,0,0,'can_be_considered','Heart failure'),
('Unexplained dyspnoea with abnormal ECG or chest radiograph',
 'shortness of breath;SOB;dyspnoea;abnormal ECG;abnormal CXR',
 'Appropriate when non-invasive tests raise suspicion of cardiac cause for breathlessness.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Heart failure;Pulmonary disease'),
('Unexplained dyspnoea with ambiguous cardiac versus pulmonary cause',
 'dyspnoea unclear cause;cardiac vs respiratory;pulmonary oedema;breathlessness',
 'TTE can help distinguish cardiac from non-cardiac dyspnoea when clinical assessment and other tests do not settle the question.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Heart failure;Pulmonary disease'),
('Known LV dysfunction or cardiomyopathy with change in clinical status',
 'known LV dysfunction;HFrEF;HFpEF;cardiomyopathy deterioration;new symptoms',
 'Repeat TTE is appropriate when symptoms, examination or therapy decisions have changed.',
 'indicated','indicated','indicated',1,0,1,0,0,'soon','Heart failure;Cardiomyopathy'),
('Routine repeat TTE in stable cardiomyopathy when management will not change',
 'stable cardiomyopathy;routine repeat echo;no clinical change;surveillance',
 'Low value when no management decision depends on the result. Specialist disease surveillance schedules may override this.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Cardiomyopathy;Heart failure'),
('Baseline or serial assessment during potentially cardiotoxic cancer therapy',
 'anthracycline;trastuzumab;HER2;chemotherapy;cardio-oncology;cardiotoxic',
 'Appropriate when local cardio-oncology pathways require baseline or surveillance LV assessment before or during cardiotoxic therapy.',
 'indicated','indicated','indicated',1,0,1,0,0,'soon','Cardio-oncology;Heart failure'),
('Essential hypertension alone with no suspected cardiac target-organ disease',
 'essential hypertension;routine hypertension;high blood pressure;screening echo',
 'BSE PUE014 lists asymptomatic hypertension with a normal cardiovascular examination as low yield even when LVH alone is reported on ECG. The 2019 nonvalvular AUC rated routine TTE without signs of hypertensive heart disease as may-be-appropriate (median 5); we retain the conservative BSE primary-care position.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Hypertension/LVH'),
('Hypertension with suspected LV dysfunction, coarctation or end-organ cardiac damage',
 'hypertension LVH;LV dysfunction;coarctation;young hypertension;end organ damage',
 'Appropriate when hypertension raises a specific structural or functional question.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Hypertension/LVH;Aortopathy'),
('Accelerated hypertension with breathlessness or suspected acute LV dysfunction',
 'accelerated hypertension;malignant hypertension;breathless hypertension;acute LV failure',
 'Urgent TTE may alter acute management where severe hypertension is accompanied by breathlessness or suspected LV dysfunction.',
 'indicated','indicated','indicated',1,0,1,0,0,'urgent','Hypertension/LVH;Heart failure'),
('Proven arrhythmia with suspected structural heart disease',
 'AF;atrial flutter;SVT;arrhythmia structural disease;abnormal ECG;palpitations',
 'Appropriate where an arrhythmia is documented and structural disease assessment will guide management.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Arrhythmia'),
('Atrial fibrillation or flutter with no clinical change after recent echocardiogram',
 'AF follow-up;atrial flutter;recent echo;no change;repeat echo',
 'Repeat imaging is usually low value when prior TTE is recent and there has been no clinical change.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Arrhythmia'),
('Palpitations without ECG proof of arrhythmia and no suspicion of structural disease',
 'palpitations;no arrhythmia;normal ECG;benign palpitations',
 'BSE/ASE-aligned low-yield referral when arrhythmia is not documented and clinical examination is reassuring.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Arrhythmia'),
('High-burden ventricular ectopy or exertional ventricular ectopy',
 'PVC burden;ventricular ectopy;ectopics >10%;Holter;exercise ectopy',
 'Appropriate because frequent or exertional ventricular ectopy can reflect structural disease and may affect risk management.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Arrhythmia;Cardiomyopathy'),
('Ventricular tachycardia or ventricular fibrillation',
 'VT;VF;wide complex tachycardia;malignant arrhythmia;cardiac arrest',
 'Appropriate and usually urgent in acute care because structural assessment can alter immediate management.',
 'indicated','indicated','indicated',1,0,1,0,0,'urgent','Arrhythmia;Critical care;Cardiomyopathy'),
('Arrhythmia with hypotension or haemodynamic compromise',
 'unstable arrhythmia;fast AF hypotension;shock arrhythmia;haemodynamic compromise',
 'Urgent inpatient TTE is appropriate when arrhythmia is accompanied by hypotension or compromise.',
 'indicated','indicated','indicated',1,0,1,0,0,'urgent','Arrhythmia;Critical care'),
('Pre-cardioversion AF when recent TTE is absent or clinical status has changed',
 'DC cardioversion;DCCV;pre cardioversion;AF >48 hours;TOE;left atrial appendage thrombus',
 'Appropriate when imaging informs cardioversion strategy, structural status, thrombus assessment or post-embolism reassessment.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Arrhythmia'),
('Emergency cardioversion requiring immediate treatment',
 'emergency cardioversion;unstable AF;urgent DCCV;immediate cardioversion',
 'Do not delay emergency cardioversion for routine pre-procedure TTE; bedside echo may still be used for shock assessment.',
 'not_indicated','can_be_considered','not_indicated',1,0,1,0,0,'can_be_considered','Arrhythmia;Critical care'),
('Classic vasovagal or situational syncope with no cardiac features',
 'vasovagal syncope;neurocardiogenic syncope;situational syncope;faint',
 'Low-yield indication when history is typical and there are no cardiac red flags.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Syncope'),
('Syncope with suspected structural or functional heart disease',
 'syncope murmur;abnormal ECG;LBBB;RBBB;LVH;cardiac syncope',
 'Appropriate and often urgent when examination, ECG or history suggests cardiac syncope.',
 'indicated','indicated','indicated',1,0,1,0,0,'urgent','Syncope;Murmur;Arrhythmia'),
('Exertional syncope',
 'exercise syncope;exertional collapse;collapse on exertion',
 'Urgent assessment is appropriate because obstructive, arrhythmic or pulmonary vascular causes may be present.',
 'indicated','indicated','indicated',1,0,1,0,0,'urgent','Syncope;Valve disease;Arrhythmia'),
('Syncope in high-risk occupation',
 'pilot;bus driver;HGV;professional driver;safety critical;occupational syncope',
 'Appropriate when occupational risk means structural cardiac exclusion will affect management.',
 'indicated','can_be_considered','indicated',1,0,1,0,0,'routine','Syncope'),
('Chest pain with normal ECG, negative biomarkers and no murmur',
 'chest pain normal ECG;negative troponin;no murmur;cardiac biomarkers negative',
 'BSE PUE014 states explicitly that standard TTE is not an appropriate test for atypical chest pain without anginal features in a low-risk patient; BSE inpatient triage agrees. Use TTE when examination, ECG or biomarkers suggest structural or ischaemic cause.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Chest pain'),
('Chest pain with haemodynamic instability',
 'unstable chest pain;shock chest pain;hypotension chest pain;acute coronary syndrome',
 'Emergency or urgent TTE can identify mechanical complications, severe valve disease, tamponade or major ventricular dysfunction.',
 'indicated','indicated','indicated',1,0,1,0,0,'urgent','Chest pain;Critical care'),
('Confirmed acute myocardial infarction to assess LV function and complications',
 'MI;myocardial infarction;STEMI;NSTEMI;post MI;LV function;mechanical complication',
 'Appropriate after confirmed MI when assessing infarct size, LV function or complications will affect care.',
 'indicated','indicated','indicated',1,0,1,0,0,'soon','Chest pain;Heart failure'),
('New murmur after recent myocardial infarction',
 'post MI murmur;papillary muscle rupture;VSD;acute MR;mechanical complication',
 'Urgent TTE is appropriate because mechanical complications may require immediate specialist intervention.',
 'indicated','indicated','indicated',1,1,1,1,0,'urgent','Chest pain;Murmur;Valve disease'),
('Suspected type A aortic dissection when TTE will not delay definitive imaging',
 'aortic dissection;acute aortic syndrome;type A dissection;chest pain aorta',
 'TTE may contribute to acute assessment, especially for complications, but should not delay CT/MR/TOE when those are the definitive local pathway.',
 'can_be_considered','can_be_considered','can_be_considered',1,0,1,0,0,'urgent','Chest pain;Aortopathy;Critical care'),
('Lung disease without suspicion of cardiac involvement or pulmonary hypertension',
 'COPD;lung disease;no PHT;no cardiac signs;respiratory disease',
 'Low-yield referral when respiratory disease explains symptoms and there are no right-heart or pulmonary hypertension features.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Pulmonary disease'),
('Lung disease with suspected right heart failure or pulmonary hypertension',
 'cor pulmonale;right heart failure;raised JVP;RV failure;pulmonary hypertension;PHT',
 'Appropriate when pulmonary disease is accompanied by clinical suspicion of RV failure or pulmonary hypertension.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Pulmonary disease'),
('Suspected or established pulmonary hypertension',
 'pulmonary hypertension;PHT;PAH;raised SPAP;RVSP;right heart',
 'Appropriate for initial probability assessment, follow-up and treatment-response questions, ideally linked to pulmonary hypertension services.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Pulmonary disease'),
('Confirmed pulmonary embolism with clinical concern for RV impairment',
 'PE;pulmonary embolus;CTPA;right heart strain;RV dysfunction',
 'Appropriate when RV findings will alter acute treatment, discharge planning or follow-up.',
 'indicated','indicated','indicated',1,0,1,0,0,'soon','Pulmonary disease;Critical care'),
('Clinically unstable pulmonary embolism where thrombolysis or thrombectomy is being considered',
 'massive PE;unstable PE;thrombolysis;thrombectomy;RV strain;shock',
 'Urgent or emergency TTE is appropriate when right-heart assessment supports reperfusion decisions.',
 'indicated','indicated','indicated',1,0,1,0,0,'urgent','Pulmonary disease;Critical care'),
('Asymptomatic post-treatment pulmonary embolism with planned outpatient follow-up',
 'post PE;stable PE;follow-up echo;right heart strain resolved',
 'Inpatient repeat imaging is usually low value if the patient is stable and outpatient follow-up is already planned.',
 'can_be_considered','not_indicated','can_be_considered',1,0,1,0,0,'can_be_considered','Pulmonary disease'),
('Unexplained persistent or positional oxygen desaturation',
 'platypnoea;orthodeoxia;oxygen desaturation;right to left shunt;bubble echo;PFO',
 'TTE, often with saline contrast, can evaluate shunt physiology when desaturation is unexplained.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Pulmonary disease;Stroke/TIA/embolism'),
('Clinically suspected pericarditis, effusion or constriction',
 'pericarditis;pericardial effusion;constriction;pericardial disease',
 'Appropriate when pericardial disease is clinically suspected or serial assessment will guide management.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Pericardial disease'),
('Suspected cardiac tamponade or pericardial fluid causing haemodynamic compromise',
 'tamponade;pericardial tamponade;haemodynamic compromise;malignancy;post surgery',
 'Emergency or urgent TTE is appropriate when pericardial fluid may be driving instability.',
 'indicated','indicated','indicated',1,0,1,0,0,'urgent','Pericardial disease;Critical care'),
('Small stable pericardial effusion without haemodynamic effect or clinical change',
 'small effusion;stable pericardial effusion;repeat echo;incidental effusion',
 'Routine repeat imaging is usually low value unless symptoms or clinical status change.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Pericardial disease'),
('Positive Duke criteria or strong clinical suspicion of infective endocarditis',
 'infective endocarditis;IE;Duke criteria;vegetation;staphylococcus aureus;bacteraemia',
 'Appropriate to characterise valve involvement and haemodynamic consequences; TOE may be needed depending on suspicion and TTE result.',
 'indicated','indicated','indicated',1,1,1,1,0,'soon','Endocarditis;Valve disease'),
('Suspected endocarditis with acute heart failure, valve decompensation or abscess concern',
 'endocarditis abscess;acute valve failure;heart failure IE;fistula;prosthetic valve IE',
 'Urgent imaging is appropriate where complications are suspected or management may escalate rapidly.',
 'indicated','indicated','indicated',1,1,1,1,0,'urgent','Endocarditis;Valve disease;Critical care'),
('Fever alone without other endocarditis criteria',
 'fever;pyrexia;no Duke criteria;screening endocarditis',
 'TTE is usually low yield for fever alone without microbiological, clinical or embolic features suggesting endocarditis.',
 'not_indicated','not_indicated','not_indicated',1,1,1,1,0,'not_indicated','Endocarditis'),
('Systemic embolism, stroke or TIA with suspected cardiac source',
 'stroke;TIA;embolism;cardiac source;intracardiac thrombus;PFO;mass',
 'Appropriate when findings may alter anticoagulation, shunt evaluation, tumour/mass assessment or further TOE decisions.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Stroke/TIA/embolism'),
('Stroke in atrial fibrillation without suspicion of structural heart disease where management will not change',
 'stroke AF;TIA AF;anticoagulation already indicated;no structural suspicion',
 'Low value if TTE will not affect anticoagulation or management; consider if murmur, LV dysfunction or other structural suspicion exists.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Stroke/TIA/embolism;Arrhythmia'),
('Suspected or known cardiac mass',
 'cardiac mass;tumour;myxoma;renal cell carcinoma;intracardiac mass;thrombus',
 'Appropriate for suspected intracardiac mass and for selected surveillance after removal or in malignancy pathways where cardiac involvement is relevant.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Stroke/TIA/embolism'),
('Routine pre-operative assessment before non-cardiac surgery',
 'pre-op echo;preoperative;non-cardiac surgery;routine surgical assessment',
 'Routine TTE before non-cardiac surgery is low value unless symptoms, murmur, poor functional capacity or known disease create a specific question.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Pre-operative'),
('Non-cardiac surgery with suspected severe valve or ventricular disease likely to alter anaesthetic plan',
 'pre-op murmur;anaesthetic risk;severe valve disease;poor functional capacity;LBBB;RBBB',
 'Appropriate when TTE findings are likely to change surgical timing, anaesthetic approach or peri-operative monitoring.',
 'indicated','indicated','indicated',1,1,1,1,0,'soon','Pre-operative;Valve disease;Heart failure'),
('Routine repeat pre-operative TTE after recent study with no clinical change',
 'repeat pre-op echo;recent echo;no change;within 12 months',
 'Low value when a recent adequate TTE answers the clinical question and status is unchanged.',
 'not_indicated','not_indicated','not_indicated',1,0,1,0,0,'not_indicated','Pre-operative'),
('Concern for tamponade after cardiac, thoracic or structural procedure',
 'post procedure tamponade;post PCI;pacemaker lead extraction;PFO closure;thoracic surgery',
 'Urgent TTE is appropriate when a complication such as tamponade is suspected after a cardiac or thoracic procedure.',
 'indicated','indicated','indicated',1,0,1,0,0,'urgent','Post-procedure;Pericardial disease;Critical care'),
('Routine pre-discharge TTE after uncomplicated valve replacement',
 'post valve replacement;pre-discharge echo;baseline prosthetic valve;asymptomatic',
 'BSE/BHVS guidance favours planned baseline haemodynamics several weeks after operation rather than routine pre-discharge imaging in stable patients.',
 'not_indicated','not_indicated','not_indicated',1,1,1,1,0,'not_indicated','Post-procedure;Prosthetic valve'),
('Baseline TTE after valve replacement or valve repair',
 'prosthetic valve baseline;valve repair baseline;TAVI baseline;MitraClip;transcatheter mitral repair',
 'Appropriate to establish baseline prosthetic or repair haemodynamics, typically around 6-8 weeks unless the operator specifies otherwise.',
 'indicated','indicated','indicated',1,1,1,1,0,'routine','Prosthetic valve;Post-procedure'),
('Suspected prosthetic valve dysfunction or new/worsening prosthetic regurgitation',
 'prosthetic valve dysfunction;prosthetic regurgitation;high gradient;EOA;mechanical valve;bioprosthetic valve',
 'Appropriate and often urgent when symptoms, gradients, regurgitation or ventricular changes suggest prosthetic dysfunction; TOE or CT may be needed.',
 'indicated','indicated','indicated',1,1,1,1,0,'soon','Prosthetic valve;Valve disease'),
('Mechanical prosthetic valve with prolonged subtherapeutic anticoagulation and concern for thrombosis',
 'mechanical valve;subtherapeutic INR;prosthetic thrombosis;valve thrombosis',
 'BHVS/BSE valve guidance flags this as needing echo or clinical discussion, especially if symptoms or abnormal valve parameters are present.',
 'can_be_considered','can_be_considered','can_be_considered',1,1,1,1,0,'soon','Prosthetic valve'),
('Severe native valve disease surveillance while asymptomatic',
 'severe AS;severe AR;severe MR;severe MS;severe TR;severe PR;valve surveillance',
 'Appropriate surveillance for severe valve disease; interval and specialist review depend on valve lesion, ventricular response and intervention candidacy.',
 'indicated','indicated','indicated',1,1,1,1,0,'soon','Valve disease'),
('Moderate native valve disease surveillance while asymptomatic',
 'moderate AS;moderate AR;moderate MR;moderate MS;moderate TR;moderate PR;valve follow-up',
 'Appropriate periodic surveillance for moderate valve disease, with sooner review if symptoms, ventricular change, pulmonary pressure or rhythm changes develop.',
 'indicated','indicated','indicated',1,1,1,1,0,'routine','Valve disease'),
('Mild native valve disease surveillance with anatomically abnormal valve',
 'mild MR;mild MS;mild AS;mild AR;prolapse;rheumatic valve;post inflammatory valve;bicuspid',
 'May be appropriate when the valve is structurally abnormal; routine surveillance is less useful for trivial or physiologic findings.',
 'can_be_considered','can_be_considered','can_be_considered',1,1,1,1,0,'routine','Valve disease'),
('Trivial or haemodynamically insignificant valve lesion with normal anatomy and no symptoms',
 'trivial MR;trace TR;physiological regurgitation;normal valve;no follow-up',
 'Generally not indicated for routine follow-up unless new symptoms or structural abnormality emerge.',
 'not_indicated','not_indicated','not_indicated',1,1,1,1,0,'not_indicated','Valve disease'),
('Valve disease with new symptoms',
 'symptomatic valve disease;dyspnoea;chest pain;syncope;heart failure symptoms',
 'Appropriate and may require urgent specialist review depending on severity, symptoms and ventricular/pulmonary pressure findings.',
 'indicated','indicated','indicated',1,1,1,1,0,'urgent','Valve disease;Heart failure;Syncope'),
('Valve disease with new LV dilatation or systolic impairment',
 'LV dilatation;LVEF low;valve alert;MR LVEF <60;AR LV size',
 'Echo finding should prompt clinical review and may shorten surveillance interval or trigger valve-team referral.',
 'indicated','indicated','indicated',1,1,1,1,0,'urgent','Valve disease;Heart failure'),
('Valve disease with new atrial fibrillation or raised pulmonary pressure',
 'new AF;SPAP;pulmonary pressure;valve red flag;right heart',
 'Appropriate because new AF or pulmonary hypertension can change risk assessment and timing of intervention.',
 'indicated','indicated','indicated',1,1,1,1,0,'soon','Valve disease;Arrhythmia;Pulmonary disease'),
('Aortic root dilatation or suspected inherited aortopathy',
 'aortic root;ascending aorta;Marfan;bicuspid aortic valve;Loeys-Dietz;aortopathy',
 'Appropriate for diagnosis and surveillance, with CT/MR used when TTE cannot define the relevant aortic segments or measurements disagree.',
 'indicated','indicated','indicated',1,1,1,1,0,'routine','Aortopathy;Congenital/inherited;Valve disease'),
('Suspected acute aortic event',
 'acute aortic syndrome;dissection;rupture;rapid aortic dilation',
 'TTE may help identify complications but should sit within an emergency cross-sectional imaging pathway.',
 'can_be_considered','can_be_considered','can_be_considered',1,0,1,0,0,'urgent','Aortopathy;Chest pain;Critical care'),
('Known adult congenital heart disease when imaging will guide management',
 'ACHD;adult congenital;shunt;repaired congenital;congenital heart disease',
 'Appropriate when structural reassessment affects surveillance, intervention planning or symptoms; specialist protocols should define interval.',
 'indicated','indicated','indicated',1,0,0,0,1,'routine','Congenital/inherited'),
('Suspected genetic or infiltrative cardiomyopathy or LVH phenotype',
 'HCM;hypertrophic cardiomyopathy;amyloid;Fabry;infiltrative;familial cardiomyopathy;first degree relative',
 'Appropriate when examination, ECG, family history or systemic disease suggests inherited or infiltrative myocardial disease.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Cardiomyopathy;Hypertension/LVH;Congenital/inherited'),
('Shock after senior clinical assessment when TTE will guide treatment',
 'shock;circulatory failure;hypotension;cardiogenic shock;septic cardiomyopathy;fluid status',
 'BSE inpatient guidance supports TTE as a primary assessment tool for shock after appropriate clinical assessment.',
 'can_be_considered','indicated','can_be_considered',1,0,1,0,0,'urgent','Critical care;Heart failure'),
('Complex fluid balance or anuric state where filling status will guide therapy',
 'fluid balance;anuria;renal replacement therapy;RRT;volume status;hypovolaemia',
 'Appropriate in selected critical care scenarios where imaging materially changes fluid or renal replacement therapy planning.',
 'not_indicated','indicated','not_indicated',1,0,1,0,0,'soon','Critical care'),
('Differentiate ARDS or pneumonitis from cardiogenic pulmonary oedema',
 'ARDS;pulmonary oedema;pneumonitis;interstitial fluid;lung ultrasound;CXR oedema',
 'Appropriate when there is reasonable suspicion that radiographic/lung ultrasound interstitial fluid reflects raised LV filling pressure.',
 'can_be_considered','indicated','can_be_considered',1,0,1,0,0,'urgent','Critical care;Heart failure;Pulmonary disease'),

-- ---------------------------------------------------------------------------
-- Rows added 2026-05-20 from direct review of ASE/ACC AUC PDFs and BSE PUE014
-- ---------------------------------------------------------------------------

-- NT-proBNP-stratified heart failure (BSE PUE014 / NICE NG106)
('Suspected heart failure with NT-proBNP above 2000 ng per litre',
 'NT-proBNP >2000;NT proBNP 2000;BNP very high;NICE 2 week;urgent heart failure;new HF urgent',
 'BSE PUE014 and NICE NG106 specify specialist heart-failure assessment and TTE within two weeks when NT-proBNP exceeds 2000 ng/L. The 2011 and 2019 ASE/ACC AUCs both rate initial TTE for suspected HF as appropriate (median 9).',
 'indicated','indicated','indicated',1,0,1,0,0,'urgent','Heart failure'),
('Suspected heart failure with NT-proBNP 400 to 2000 ng per litre',
 'NT-proBNP 400-2000;NT proBNP intermediate;BNP intermediate;NICE 6 week;routine heart failure;NICE NG106',
 'BSE PUE014 and NICE NG106 specify specialist heart-failure assessment with TTE within six weeks when NT-proBNP is between 400 and 2000 ng/L.',
 'indicated','indicated','indicated',1,0,1,0,0,'soon','Heart failure'),
('Suspected heart failure with NT-proBNP below 400 ng per litre',
 'NT-proBNP <400;low BNP;NICE NG106;HF unlikely;not heart failure',
 'BSE PUE014 and NICE NG106 regard heart failure as unlikely when NT-proBNP is below 400 ng/L; pursue alternative diagnoses. Other indications (murmur, arrhythmia, suspected structural disease) may still independently justify a TTE.',
 'not_indicated','not_indicated','not_indicated',0,0,1,0,0,'not_indicated','Heart failure'),

-- Newly diagnosed conduction disease (2019 nonvalvular AUC)
('Newly diagnosed left bundle branch block',
 'LBBB;left bundle branch block;new LBBB;wide QRS;conduction abnormality',
 '2019 ACC/AHA/ASE nonvalvular AUC rates TTE appropriate (median 7) for newly diagnosed LBBB because LV systolic dysfunction or other structural disease is often uncovered.',
 'indicated','indicated','indicated',1,0,1,0,0,'routine','Arrhythmia;Heart failure'),
('Newly diagnosed right bundle branch block in an otherwise well patient',
 'RBBB;right bundle branch block;new RBBB;isolated RBBB',
 '2019 ACC/AHA/ASE nonvalvular AUC rates TTE only may-be-appropriate (median 5) when RBBB is isolated and the patient is otherwise well. Prioritise TTE for symptoms, abnormal examination or other ECG/imaging concern.',
 'can_be_considered','can_be_considered','can_be_considered',1,0,0,0,0,'routine','Arrhythmia'),

-- Isolated sinus bradycardia (2011 AUC)
('Asymptomatic isolated sinus bradycardia',
 'sinus bradycardia;low heart rate;bradycardia athlete;asymptomatic bradycardia',
 '2011 ACCF/ASE AUC rates TTE inappropriate (median 2) for asymptomatic isolated sinus bradycardia without other features suggesting structural or functional disease.',
 'not_indicated','not_indicated','not_indicated',1,0,0,0,0,'not_indicated','Arrhythmia'),

-- Severe blunt cardiac trauma (2011 AUC Table 2)
('Severe blunt cardiac trauma or deceleration injury',
 'cardiac trauma;blunt chest trauma;deceleration injury;road traffic accident;rib fractures;sternal fracture',
 '2011 ACCF/ASE AUC rates TTE appropriate (median 9) when deceleration injury or severe chest trauma raises concern for valve injury, pericardial effusion or contusion. Routine TTE for trivial chest trauma with normal ECG and biomarkers is inappropriate.',
 'indicated','indicated','indicated',1,0,0,0,0,'urgent','Chest pain;Critical care;Pericardial disease'),

-- VHD additions (2017 VHD AUC and BSE PUE014)
('First-degree relative of a patient with a bicuspid aortic valve',
 'bicuspid aortic valve;BAV;family history;first degree relative;screening BAV;inherited valve disease',
 '2017 ACC/AHA/ASE VHD AUC rates initial TTE appropriate (median 8) for first-degree relatives of a bicuspid aortic valve patient. BSE PUE014 lists this as an echo-recommended primary-care indication.',
 'indicated','indicated','indicated',1,0,1,1,0,'routine','Valve disease;Aortopathy;Congenital/inherited'),
('Bicuspid aortic valve with ascending aortic dilatation',
 'bicuspid aortic valve;BAV aortopathy;ascending aorta;aortic root;BAV with aneurysm',
 '2017 VHD AUC recommends annual TTE (median 7) when the ascending aorta is >4 cm with any of: aortic diameter >4.5 cm, rapid expansion, or first-degree family history of dissection. Stable BAV with diameter 4.0-4.5 cm and no risk factors usually does not need annual imaging.',
 'indicated','indicated','indicated',1,1,1,1,0,'routine','Valve disease;Aortopathy;Congenital/inherited'),
('Stage A surveillance of bicuspid aortic valve or aortic sclerosis without progression',
 'stage A VHD;bicuspid aortic valve surveillance;aortic sclerosis;long interval surveillance;3-5 years',
 '2017 VHD AUC rates a 3-to-5-year surveillance TTE as appropriate (median 9) for stage A VHD without progression. More frequent imaging without symptoms or examination change is low value.',
 'indicated','can_be_considered','indicated',1,1,1,1,0,'routine','Valve disease'),
('Severe asymptomatic aortic stenosis prior to non-cardiac surgery or pregnancy',
 'severe AS pregnancy;severe AS surgery;asymptomatic AS;preoperative AS;haemodynamic demand;non-cardiac surgery AS',
 '2017 VHD AUC rates a TTE within one year as may-be-appropriate (median 6) when severe AS faces increased haemodynamic demand. BHVS surveillance typically shortens this interval; coordinate with the local valve team.',
 'indicated','indicated','indicated',1,1,1,1,0,'soon','Valve disease;Pre-operative'),
('Pre-pregnancy evaluation in prosthetic valve patient without recent echocardiogram',
 'pre-pregnancy echo;prosthetic valve pregnancy;valve replacement pregnancy;maternal cardiology;BHVS pregnancy',
 '2017 VHD AUC rates pre-pregnancy TTE appropriate (median 9) in any prosthetic valve patient without an echocardiogram in the past year, to confirm valve function and pulmonary pressures before conception.',
 'indicated','indicated','indicated',1,1,1,1,0,'routine','Prosthetic valve;Valve disease'),

-- BSE PUE014 explicit primary-care exclusions
('Mild aortic regurgitation with structurally normal valve and aortic root under 40 mm',
 'mild AR;mild aortic regurgitation;normal valve;aortic root <40;low yield AR;follow-up mild AR',
 'BSE PUE014 explicitly classifies follow-up TTE for mild AR with a structurally normal valve and aortic root <40 mm as not indicated in primary care. Re-image if symptoms develop or the aortic root enlarges.',
 'not_indicated','not_indicated','not_indicated',0,0,1,1,0,'not_indicated','Valve disease'),
('Family history of ischaemic heart disease in an asymptomatic individual',
 'family history IHD;family history MI;FHx CAD;asymptomatic coronary risk;screening echo',
 'BSE PUE014 lists family history of ischaemic heart disease alone as low yield for TTE in an asymptomatic individual. Use cardiovascular risk assessment rather than echo as the first step.',
 'not_indicated','not_indicated','not_indicated',0,0,1,0,0,'not_indicated','Chest pain'),
('Echocardiography unlikely to alter management, including advanced frailty',
 'advanced frailty;end of life;palliative;ceiling of care;futile echo;not for intervention',
 'BSE PUE014 and BSE 2022 triage both classify TTE as not indicated when the result would not change management, typically advanced frailty, palliative care plans or a documented ceiling of care.',
 'not_indicated','not_indicated','not_indicated',0,0,1,0,0,'not_indicated','Heart failure;Valve disease;Arrhythmia');

UPDATE indications i
JOIN import_blended_indications r ON i.title = r.title
SET i.keywords = r.keywords,
    i.comments = r.comments,
    i.primary_care = r.primary_care,
    i.secondary_inpatient = r.secondary_inpatient,
    i.secondary_outpatient = r.secondary_outpatient,
    i.source_ase = r.source_ase,
    i.source_eacvi = r.source_eacvi,
    i.source_bse = r.source_bse,
    i.source_bhvs = r.source_bhvs,
    i.source_consensus = r.source_consensus,
    i.urgency = r.urgency;

INSERT INTO indications
(title, keywords, comments, primary_care, secondary_inpatient, secondary_outpatient,
 source_ase, source_eacvi, source_bse, source_bhvs, source_consensus, urgency)
SELECT r.title, r.keywords, r.comments, r.primary_care, r.secondary_inpatient, r.secondary_outpatient,
       r.source_ase, r.source_eacvi, r.source_bse, r.source_bhvs, r.source_consensus, r.urgency
FROM import_blended_indications r
WHERE NOT EXISTS (SELECT 1 FROM indications i WHERE i.title = r.title);

DELETE ic
FROM indication_contexts ic
JOIN indications i ON i.id = ic.indication_id
JOIN import_blended_indications r ON r.title = i.title;

INSERT INTO indication_contexts (indication_id, context_id)
SELECT i.id, c.id
FROM import_blended_indications r
JOIN indications i ON i.title = r.title
JOIN contexts c ON FIND_IN_SET(c.name, REPLACE(r.contexts, ';', ',')) > 0
WHERE NOT EXISTS (
  SELECT 1
  FROM indication_contexts ic
  WHERE ic.indication_id = i.id AND ic.context_id = c.id
);

DROP TEMPORARY TABLE import_blended_indications;

COMMIT;

