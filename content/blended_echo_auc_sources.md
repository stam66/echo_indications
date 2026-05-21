# Blended Adult Echocardiography AUC Content Sources

Draft generated 2026-05-19. Source-PDF verification pass on 2026-05-20. This content pack is intended for clinical review before production import.

Primary sources reviewed:

- British Society of Echocardiography. Bennett et al. "Clinical indications and triaging for adult transthoracic echocardiography: a statement by the British Society of Echocardiography." Echo Research & Practice, 2022. https://link.springer.com/article/10.1186/s44156-022-00003-8
- British Society of Echocardiography / British Heart Valve Society. "Clinical indications and triage of echocardiography: Heart valve disease", 2024. https://bhvs.org/wp-content/uploads/2024/08/PUE004_Clinical-indications-triage_Heart-valve-disease.pdf
- British Society of Echocardiography, Primary Care Cardiovascular Society & British Society for Heart Failure. "Making best use of echocardiography in primary care (PUE014)", 2024. Local copy: `resources/Documents/PUE014_primary-care-triage-poster.pdf`.
- Chambers et al. "Indications for echocardiography of replacement heart valves: a joint statement from the British Heart Valve Society and British Society of Echocardiography." Echo Research & Practice, 2019. https://pmc.ncbi.nlm.nih.gov/articles/PMC6410760/
- European Association of Cardiovascular Imaging / ESC. "Appropriateness criteria development process", 2014. https://www.escardio.org/static-file/Escardio/Subspecialty/EACVI/position-papers/appropraiteness-criteria.pdf
- Lancellotti et al. "Appropriateness criteria for the use of cardiovascular imaging in heart valve disease in adults: an EACVI report." European Heart Journal - Cardiovascular Imaging, 2017.
- ACC/AATS/AHA/ASE/ASNC/HRS/SCAI/SCCT/SCMR/STS. "2019 Appropriate Use Criteria for Multimodality Imaging in the Assessment of Cardiac Structure and Function in Nonvalvular Heart Disease." https://www.asecho.org/guideline/acc-aats-aha-ase-asnc-hrs-scai-scct-scmr-sts-2019-appropriate-use-criteria-for-multimodality-imaging-in-the-assessment-of-cardiac-structure-and-function-in-nonvalvular-heart-disease/
- ACCF/ASE/AHA/ASNC/HFSA/HRS/SCAI/SCCM/SCCT/SCMR. "2011 Appropriate Use Criteria for Echocardiography." https://www.asecho.org/wp-content/uploads/2025/04/Appropriate-Use-Criteria-for-Echo_2011.pdf
- ACC/AATS/AHA/ASE/ASNC/HRS/SCAI/SCCT/SCMR/STS. "2017 Appropriate Use Criteria for Multimodality Imaging in Valvular Heart Disease." https://www.jacc.org/doi/10.1016/j.jacc.2017.07.732

Normalization notes:

- `title` is a concise, paraphrased clinical concept rather than copied guideline text.
- `keywords` contains synonyms, common misspellings, abbreviations and search terms.
- `comments` records rationale, caveats and merged attribution in compact prose.
- `primary_care`, `secondary_inpatient` and `secondary_outpatient` use the app's existing verdict enum: `indicated`, `not_indicated`, `can_be_considered`.
- `urgency` is a simplified operational triage label for the whole indication. Some rows still require local policy to convert into exact waiting-list targets.
- BHVS attribution requires `migrations/2026-05-19_add_bhvs_source.sql`.

## Source-PDF verification (2026-05-20)

The 2011 ACCF/ASE, 2017 VHD and 2019 nonvalvular ACC/AHA/ASE AUC documents were read directly from the PDFs supplied by the project owner (`resources/Documents/`). The 2024 BSE/PCCS primary-care triage poster (PUE014) was also incorporated. The ASE/ACC mapping used was: median appropriateness score 7–9 → `indicated`, 4–6 → `can_be_considered`, 1–3 → `not_indicated`.

Rows added or refined during this pass include:

- NICE/BSE NT-proBNP-stratified heart failure triage (>2000, 400–2000, <400 ng/L).
- Newly diagnosed LBBB (2019 AUC A(7)) and newly diagnosed RBBB (2019 AUC M(5)).
- Asymptomatic isolated sinus bradycardia (2011 AUC I(2)).
- Severe blunt cardiac trauma or deceleration injury (2011 AUC A(9)).
- Pre-pregnancy assessment in prosthetic valve patients without a recent study (2017 VHD A(9)).
- First-degree relative of a bicuspid aortic valve (2017 VHD A(8); BSE primary-care explicit).
- Bicuspid aortic valve with ascending aortic dilatation, including the risk-factor split at ≥4.5 cm / rapid expansion / family history of dissection (2017 VHD A(7)).
- Stage A VHD surveillance (bicuspid AV without dilation or aortic sclerosis) every 3–5 years (2017 VHD A(9)).
- Severe asymptomatic aortic stenosis facing increased haemodynamic demand — non-cardiac surgery or pregnancy (2017 VHD M(6)).
- Mild aortic regurgitation with a structurally normal valve and aortic root <40 mm — explicit low-yield exclusion from BSE primary care.
- Family history of ischaemic heart disease in an asymptomatic individual — BSE primary care.
- "Echocardiography unlikely to alter management" (advanced frailty, end-of-life) — BSE primary care.

