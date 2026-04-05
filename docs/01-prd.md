# PRD — My Vet&Go Galaxy

**Auteur :** Arnaud
**Date :** Avril 2026
**Statut :** Draft v1 — Vision ambitieuse « Galaxy »
**Parties prenantes :** Camille (Ops), Elizabeth (Clinique), David (Direction), Arnaud (Produit & Tech)
**Documents de référence :** market-sizing-galaxy.md, competitor-analysis-galaxy.md, prd-myvetandgo.md (version niche), deep-market-research-v2.md

---

## 1. Résumé exécutif

Nous construisons **My Vet&Go Galaxy** — la plateforme de référence en formation continue vétérinaire pour les animaux de compagnie dans l'espace francophone et néerlandophone. Galaxy est l'ambition finale du projet My Vet&Go : passer de la niche urgence (TAM ±1,2 M€, ±5 800 vétérinaires) à une couverture complète de **20+ spécialités** ciblant **±26 430 vétérinaires** sur 5 pays (France, Belgique, Luxembourg, Pays-Bas, Suisse romande), pour un TAM de **±7,9 M€**.

La stratégie est concentrique : lancer en niche urgence pour la crédibilité (Phase 1), puis étendre progressivement vers les spécialités adjacentes (Phase 2–3), jusqu'à devenir la « bible de la FC vétérinaire » (Phase 4–5). Galaxy combine quatre différenciateurs qu'aucun concurrent ne réunit : **parcours de spécialité structurés et progressifs** (vs. webconférences isolées de 15 min chez Wizzvet), **recherche IA clinique transversale** (outil de référence quotidien), **bilinguisme natif FR/NL** (unique sur le marché), et **accréditations multi-pays** (CFCV, CRFOMV/NGROD, SVS, CKRD).

En scénario réaliste, l'objectif à 5 ans est d'atteindre **5 500 abonnés** et un **ARR de ±2 M€**, avec un mix B2C individuel et B2B groupes vétérinaires.

---

## 2. Énoncé du problème

### Qui a ce problème ?

Les **±26 430 vétérinaires animaux de compagnie** exerçant en France, Belgique, Luxembourg, Pays-Bas et Suisse romande. Ce marché comprend des urgentistes dédiés, des généralistes assurant des gardes, des spécialistes de chaque discipline, et des praticiens généralistes cherchant à approfondir une ou plusieurs spécialités.

### Quel est le problème ?

La formation continue vétérinaire en Europe francophone et néerlandophone souffre de **quatre carences structurelles** :

**Pas de parcours structurés.** L'offre e-learning existante (Wizzvet, VETtube, VetVisuals) propose des webconférences isolées de 15 minutes sans progression pédagogique. Un vétérinaire qui veut approfondir la dentisterie, le comportement ou la neurologie ne trouve aucun parcours progressif « débutant → avancé » entre les webconférences courtes et les diplômes longs (CEAV, GPCert à 4 000–9 900 €). L'espace intermédiaire — des cursus de 10–40 heures certifiants par spécialité — est totalement vide.

**Pas de référence clinique intégrée.** Les vétérinaires en consultation ou en garde n'ont aucun outil de recherche rapide dans le contenu de formation. Ils doivent naviguer manuellement dans des catalogues plats pour retrouver une procédure spécifique. Ce qui devrait prendre 30 secondes prend 10+ minutes.

**Pas de bilinguisme.** Le Benelux est coupé en deux : Wizzvet est francophone, VetVisuals est néerlandophone, VETgirl et VIN sont anglophones. Les cliniques belges bilingues et les groupes vétérinaires opérant dans les deux communautés (IVC Evidensia, AniCura) n'ont aucune solution unifiée.

**Pas d'outil employeur.** Les responsables de cliniques et groupes vétérinaires n'ont aucun moyen de suivre la formation de leurs équipes, de garantir la conformité réglementaire ou de mesurer le ROI de leur investissement FC.

### Pourquoi est-ce douloureux ?

**Impact utilisateur :** Les vétérinaires perdent du temps et de l'argent en formations fragmentées. Ils accumulent des webconférences de 15 min sans réelle progression de compétence. Sous stress en consultation, ils ne trouvent pas l'information dont ils ont besoin. Le sentiment de stagnation contribue au burnout et au turnover (37 % des nouveaux vétérinaires belges quittent après 3 ans).

**Impact business :** Le marché de la FC e-learning vétérinaire (±11–13 M€/an sur 5 pays) est fragmenté et sous-exploité. Aucun acteur n'a réussi à devenir la référence multi-spécialités bilingue. La consolidation corporative des cliniques (IVC Evidensia 2 000+ cliniques, AniCura 500+) crée une demande B2B non satisfaite.

### Preuves

- **Market research v2 :** Le marché e-learning FC vétérinaire sur 5 pays = ±11–13 M€/an, CAGR 8–10 %. 5 spécialités « blue ocean » identifiées sans e-learning FR/NL.
- **Analyse concurrentielle Galaxy :** Wizzvet (12 000 membres) ne propose que des webconférences de 15 min sans parcours progressif. VetVisuals (575 €/an) est néerlandophone uniquement et technologiquement datée.
- **Benchmarks internationaux :** VETgirl (50 000–100 000 utilisateurs, 269 $/an) et VIN (90 000 membres, 780 $/an) prouvent la viabilité du modèle d'abonnement multi-spécialités.
- **Validation niche urgence :** L'atelier Vet&Go (mars 2026) a confirmé le besoin de structuration, de certification et de recherche rapide — besoins transposables à toutes les spécialités.
- **Pression réglementaire :** FC obligatoire dans 4/5 pays. David (direction Vet&Go) a reçu un blâme de l'Ordre pour retard FC.

---

## 3. Utilisateurs cibles et personas

### Persona primaire : Le vétérinaire généraliste en quête de spécialisation

**Profil :** Vétérinaire animaux de compagnie, 3–15 ans d'expérience, exerçant en clinique généraliste en France, Belgique ou Suisse romande. Francophone ou néerlandophone. Souhaite approfondir 2–3 spécialités (ex : dentisterie, dermatologie, comportement) mais n'a ni le temps ni le budget pour un diplôme universitaire.

**Objectifs :**
- Approfondir ses compétences dans 2–3 spécialités cliniques de manière progressive
- Obtenir ses points de FC obligatoires directement via du contenu pertinent pour sa pratique
- Disposer d'un outil de référence rapide consultable pendant ou entre les consultations

**Frustrations :**
- Les webconférences de 15 min (Wizzvet) ne permettent pas d'approfondir un sujet
- Les diplômes longs (CEAV, GPCert) coûtent 4 000–9 900 € et prennent 18+ mois
- Les plateformes ECC (VECCS, VETgirl) sont exclusivement anglophones
- Le contenu gratuit des labos est biaisé et superficiel

### Persona secondaire : Le responsable de clinique / groupe vétérinaire

**Profil :** Directeur(trice) de clinique ou responsable formation dans un groupe vétérinaire (IVC Evidensia, AniCura, clinique multi-sites). Supervise 5–50+ vétérinaires.

**Objectifs :**
- Garantir la conformité FC de toute l'équipe (obligation légale)
- Centraliser la formation sur une seule plateforme bilingue FR/NL
- Mesurer le ROI de l'investissement formation (analytics, progression, compétences)
- Utiliser la formation comme levier de recrutement et rétention

**Frustrations :**
- Aucune plateforme ne propose de tableau de bord employeur avec suivi de formation d'équipe
- Impossible de couvrir FR et NL avec un seul outil
- Les formations sont dispersées (Wizzvet + VetVisuals + congrès + labos)

### Persona tertiaire : Le vétérinaire urgentiste (persona fondateur)

**Profil :** Persona d'origine de My Vet&Go niche. Vétérinaire en clinique d'urgence ou généraliste assurant des gardes. Besoin quotidien de référence clinique rapide + certification urgence.

**Objectifs :** Identiques au PRD niche (référence rapide, certification FC urgence, progression en médecine d'urgence).

**Rôle Galaxy :** C'est le premier segment conquis (Phase 1). Sa satisfaction valide le modèle avant l'extension multi-spécialités.

### Persona quaternaire : L'assistant(e) spécialisé(e) vétérinaire (ASV)

**Profil :** ASV en poste ou en formation. Pas d'obligation FC réglementaire mais besoin de formation technique (machines, actes, chirurgie).

**Rôle Galaxy :** Segment additionnel à couvrir progressivement. Volume élevé (±30 000–40 000 en zone cible), budget FC modeste (100–200 €/an).

---

## 4. Contexte stratégique

### Objectifs business Galaxy

| Objectif | Lien avec Galaxy |
|---|---|
| Devenir la plateforme de référence FC vétérinaire en Europe francophone/néerlandophone | Couverture 20+ spécialités, bilinguisme natif, accréditations multi-pays |
| Atteindre un ARR de 2 M€ en 5 ans | 5 500 abonnés (B2C + B2B) × 295 € ARPU effectif |
| Créer un fossé concurrentiel défensif | IA clinique + parcours structurés + bilinguisme = combinaison non réplicable rapidement |
| Ouvrir le canal B2B groupes vétérinaires | Licences groupées IVC Evidensia, AniCura, VetPartners — potentiel 2,25–3,15 M€ |
| Valoriser l'expertise fondatrice ACVECC de Vet&Go | L'urgence comme base de crédibilité pour l'expansion multi-spécialités |

### Opportunité de marché

*(Source : market-sizing-galaxy.md — avril 2026)*

| Métrique | Niche urgence (actuel) | Galaxy (ambitieux) | Facteur |
|---|---|---|---|
| Vétérinaires cibles | ±5 800 | ±26 430 | ×4,6 |
| TAM | ±1,15 M€ | ±7,9 M€ | **×6,9** |
| SAM (B2C) | ±405 K€ | ±1,56 M€ | ×3,9 |
| SAM élargi (B2C + B2B) | — | ±3,8–4,7 M€ | — |
| SOM An 3 (réaliste) | ±147 K€ | ±747 K€ | **×5,1** |
| SOM An 5 (réaliste) | ±300 K€ | ±2 073 K€ | **×6,9** |

### Paysage concurrentiel

*(Source : competitor-analysis-galaxy.md — avril 2026)*

| Concurrent | Position | Menace Galaxy |
|---|---|---|
| **Wizzvet** | Leader FR e-learning, 12 000 membres, mais format court + pas de parcours structurés | **Élevée** |
| **VetVisuals** | Leader NL, 575 €/an, LMS daté | **Moyenne** |
| **ENVF-FTLV** | Projet France 2030, digitalisation lente des 4 ENV | **Moyenne-Élevée (2028+)** |
| **VETgirl** | Benchmark tarifaire mondial (269 $/an), anglophone uniquement | **Moyenne** |
| **VIN** | Référence mondiale communauté + FC, 780 $/an, anglophone | **Moyenne-Faible** |

**Constat stratégique :** Aucun concurrent ne combine parcours structurés + bilinguisme FR/NL + IA clinique + accréditation multi-pays + prix compétitif.

### Pourquoi maintenant ?

**Fenêtre de marché ouverte.** Wizzvet domine mais sans parcours structurés. Les ENVF mettent 6 ans à se digitaliser. VetVisuals est technologiquement datée. Le moment est propice pour s'établir avant que ces acteurs ne comblent leurs lacunes.

**Consolidation corporative accélérée.** IVC Evidensia (2 000+ cliniques), AniCura (500+), VetPartners centralisent les achats FC. La demande B2B émerge maintenant — les premières plateformes à proposer des dashboards employeur captent ces contrats.

**IA mûre pour l'EdTech.** Les technologies RAG (Retrieval-Augmented Generation) sont matures et abordables en 2026. Intégrer l'IA clinique dès la conception crée un avantage de premier entrant difficile à rattraper.

**Validation du modèle en niche.** Le PRD niche urgence est défini, l'architecture technique est prête. Galaxy n'est pas un redémarrage — c'est l'extension planifiée d'une fondation validée.

---

## 5. Vue d'ensemble de la solution

### Vision produit Galaxy

My Vet&Go Galaxy est une plateforme de FC vétérinaire en **4 couches** :

**Couche 1 — Référencer (IA clinique).** Une recherche conversationnelle IA dans les transcripts vidéo de toutes les spécialités. Le vétérinaire en consultation tape « protocole anesthésie brachycéphale chat » et obtient une réponse contextualisée avec liens directs vers les passages vidéo pertinents. Ce n'est pas du e-learning — c'est un **outil de travail quotidien**.

**Couche 2 — Apprendre (parcours structurés).** Des cursus ordonnés de 10–40 heures par spécialité, avec une progression pédagogique « débutant → intermédiaire → avancé ». Chaque cursus combine vidéos longues segmentées en chapitres de 5–15 min, cas cliniques interactifs et évaluations intermédiaires. Le vétérinaire progresse à son rythme, reprend là où il s'est arrêté, et obtient une vue claire de sa montée en compétence.

**Couche 3 — Valider (certification accréditée).** Des quiz certifiants post-vidéo attribuant automatiquement des points de FC reconnus par les ordres vétérinaires de chaque pays cible. Génération automatique de certificats PDF. Suivi de conformité individuel et par équipe.

**Couche 4 — Gérer (employeur / B2B).** Un tableau de bord pour les responsables de cliniques et groupes vétérinaires : heatmap de progression d'équipe, analytics de formation, reporting de conformité, gestion de licences groupées.

### Cartographie des spécialités Galaxy

L'expansion suit une stratégie concentrique basée sur le market research v2 :

**Vague 1 — Fondation urgence (An 1) :** Urgences/ECC. Crédibilité ACVECC, modèle validé.

**Vague 2 — Adjacences urgence (An 1–2) :** Anesthésie/analgésie (transversal, 95 % des vétérinaires), imagerie d'urgence (radiographie thorax, FAST écho), dentisterie (blue ocean #1).

**Vague 3 — Spécialités à forte demande (An 2–3) :** Dermatologie (85–90 %), chirurgie tissus mous (75–85 %), oncologie (60–70 %), comportement (55–65 %, blue ocean), médecine féline (65–80 %), cardiologie (60–70 %).

**Vague 4 — Couverture complète (An 3–5) :** Neurologie (blue ocean), endocrinologie, NAC (blue ocean), ostéopathie/physiothérapie (blue ocean), ophtalmologie, pharmacologie clinique, chirurgie orthopédique.

**Spécialités exclues :** Nutrition clinique, médecine préventive/vaccination, parasitologie — saturées par le contenu gratuit pharma.

### Architecture de navigation Galaxy

```
┌─ Choix de la langue (FR / NL)
│
├─ Accueil personnalisé
│   ├─ Mes cursus en cours (progression)
│   ├─ Recommandations (basées sur spécialités suivies)
│   └─ Nouveautés de la semaine
│
├─ Explorer les spécialités
│   ├─ Urgences/ECC
│   │   ├─ Cursus par système (digestif, respiratoire, cardio...)
│   │   ├─ Cursus transversaux (polytrauma, choc, toxicologie...)
│   │   └─ Référence rapide (chapitres individuels)
│   ├─ Anesthésie/Analgésie
│   │   ├─ Cursus débutant → avancé
│   │   └─ Protocoles par espèce/procédure
│   ├─ Dentisterie
│   │   ├─ Cursus débutant → avancé
│   │   └─ Vidéos procédurales
│   ├─ Dermatologie
│   ├─ Imagerie médicale
│   ├─ Chirurgie
│   ├─ Oncologie
│   ├─ Comportement
│   ├─ Médecine féline
│   ├─ Cardiologie
│   ├─ Neurologie
│   ├─ ... (20+ spécialités à terme)
│   │
│   └─ Section ASV
│       ├─ Machines et équipement
│       ├─ Actes pratiques
│       └─ Assistance chirurgicale
│
├─ Recherche IA clinique (transversale)
│   └─ "protocole anesthésie brachycéphale chat"
│       → Réponse contextualisée + liens vidéo + timestamps
│
├─ Mon profil
│   ├─ Carte de compétences (radar par spécialité)
│   ├─ Points FC cumulés (par organisme accrédité)
│   ├─ Cursus en cours et terminés
│   ├─ Mes certificats
│   └─ Préférences (langue, dark mode, notifications)
│
└─ Dashboard Manager (B2B)
    ├─ Heatmap progression d'équipe (par spécialité)
    ├─ Conformité FC par collaborateur
    ├─ Analytics (temps passé, vidéos populaires, taux de complétion)
    ├─ Gestion des licences
    └─ Export reporting (Excel, PDF)
```

### Fonctionnalités clés par phase Galaxy

#### Phase 1 — Fondation urgence (Mois 0–12)

Identique au PRD niche urgence v2 : structure en cursus, navigation, profils utilisateurs, suivi de visionnage, chapitres vidéo, dark mode, support NL.

#### Phase 2 — Certification + premières extensions (Mois 6–18)

- Quiz certifiants multi-spécialités (même moteur que niche, étendu)
- Calcul automatique des points FC
- Certificats PDF avec mention de l'organisme accréditeur
- Tableau de bord manager (heatmap, filtres, export Excel)
- Gamification légère (streaks, animations, récap mensuel)
- **Ajout des spécialités Vague 2** : anesthésie, imagerie, dentisterie
- Recrutement des premiers formateurs hors ECC

#### Phase 3 — IA clinique + expansion multi-spécialités (Mois 12–24)

- Recherche IA conversationnelle transversale (RAG sur transcripts de toutes spécialités)
- **Ajout des spécialités Vague 3** : dermatologie, chirurgie, oncologie, comportement, féline, cardiologie
- Carte de compétences par spécialité (profil utilisateur)
- Recommandations personnalisées (basées sur spécialités suivies et complétées)
- Section ASV structurée
- Contenu NL natif (pas seulement sous-titré)

#### Phase 4 — Commercialisation multi-pays (Mois 18–30)

- Accès externe (inscription ouverte)
- Tarification : 299 €/an all-inclusive (individuel), tiers Enterprise (B2B dégressif)
- Intégration Stripe
- Site marketing multilingue ciblant les 5 pays
- Accréditations multi-pays en parallèle (CFCV, CRFOMV, NGROD, SVS, CKRD)
- Partenariats hybrides GEUR/AFVAC (France, 100 % crédits FC)
- Certification Qualiopi (accès FIF-PL, OPCO)

#### Phase 5 — Bible complète + B2B (Mois 24–48)

- **Couverture complète (20+ spécialités)** : ajout Vague 4
- Dashboard B2B avancé (multi-sites, analytics agrégées, benchmarking)
- Contrats B2B groupes vétérinaires (IVC Evidensia, AniCura, VetPartners)
- Communauté / social learning (commentaires contextuels par vidéo)
- App mobile native (iOS/Android) — ou PWA optimisée
- Parcours certifiants par spécialité (« Certificat My Vet&Go en Dentisterie », etc.)
- Personnalisation avancée (IA recommandations, parcours adaptatifs)

---

## 6. Métriques de succès

### Métrique primaire Galaxy

**ARR (Annual Recurring Revenue)**
- An 1 : 50 K€
- An 3 : 747 K€
- An 5 : 2 073 K€
- Mesure : Stripe MRR × 12 + contrats B2B annualisés

### Métriques secondaires

| Métrique | Cible An 1 | Cible An 3 | Cible An 5 |
|---|---|---|---|
| Abonnés totaux (B2C + B2B) | 200 | 2 200 | 5 500 |
| Taux d'utilisation mensuelle | 80 % | 75 % | 70 % |
| Spécialités couvertes | 3 | 10 | 20+ |
| Points FC moyens obtenus / vétérinaire / an | 10 | 15 | 18 |
| NPS | > 40 | > 45 | > 50 |
| Churn annuel | < 20 % | < 15 % | < 12 % |
| Revenus B2B / revenus totaux | 0 % | 16 % | 22 % |
| Temps de recherche clinique (IA) | — | < 30 sec | < 15 sec |

### Métriques de garde-fou

| Métrique | Seuil d'alerte |
|---|---|
| Churn mensuel | > 2,5 % (annualisé > 26 %) |
| NPS | < 30 |
| Taux de dismissal quiz | > 50 % |
| Temps de chargement vidéo | > 3 sec |
| Coût d'acquisition client (CAC) | > 150 € (payback > 6 mois) |

---

## 7. Hors périmètre

| Fonctionnalité exclue | Raison |
|---|---|
| Contenu animaux de production / équins | Marché différent, autres experts, autre audience |
| Diplômes longs type CEAV ou GPCert | Territoire des ENVF et Improve International |
| FC gratuite pharma (nutrition, parasitologie, vaccination) | Saturé par le contenu gratuit, ROI trop faible |
| Application mobile native (Phase 1–3) | Responsive web first ; app native Phase 5 si adoption mobile > 40 % |
| Marketplace de formateurs (modèle Udemy) | Contrôle éditorial strict — les formateurs sont recrutés et validés, pas auto-publiés |
| Messagerie temps réel entre utilisateurs | Complexité disproportionnée ; commentaires contextuels en Phase 5 |
| Intégration avec les systèmes RH des groupes vétérinaires | Trop spécifique ; export Excel/PDF suffit dans un premier temps |

---

## 8. Dépendances et risques

### Dépendances critiques Galaxy

| Dépendance | Type | Impact | Responsable |
|---|---|---|---|
| Recrutement de 50–100+ formateurs spécialistes | Contenu | **Bloquant pour Phases 2–5** — Galaxy ne peut exister sans contenu multi-spécialités | Arnaud + partenariats AFVAC |
| Accréditations multi-pays (CFCV, CRFOMV, NGROD, SVS, CKRD) | Réglementaire | **Critique** — sans accréditation, SAM divisé par 3–4× | Camille + démarches externes |
| Certification Qualiopi (France) | Réglementaire | **Bloquant pour marché français** — accès FIF-PL, OPCO | Arnaud |
| Budget de développement élargi (vs. niche) | Business | **Bloquant** — Galaxy nécessite un investissement 3–5× supérieur au niche | David (direction) |
| Partenariats AFVAC / sociétés savantes | Contenu + crédibilité | Accélérateur majeur pour recrutement de formateurs et parcours hybrides | Arnaud + Camille |
| Production de contenu NL natif | Contenu | Nécessaire pour le marché néerlandophone (pas seulement des sous-titres) | À recruter |

### Risques Galaxy

| Risque | Probabilité | Impact | Mitigation |
|---|---|---|---|
| Incapacité à recruter suffisamment de formateurs spécialistes | Moyenne | **Critique** — bloque l'expansion multi-spécialités | Partenariats AFVAC/sociétés savantes, rémunération attractive, co-production |
| Wizzvet lance des parcours structurés | Moyenne | **Élevé** — élimine un différenciateur clé | Avancer vite sur les blue oceans (dentisterie, comportement, NAC), IA comme barrière |
| Budget insuffisant pour l'ambition Galaxy | Élevée | **Critique** — Galaxy tronqué ou abandonné | Phasing progressif, prouver le modèle en niche avant d'investir |
| Accréditations multi-pays retardées > 24 mois | Moyenne | **Élevé** — SOM amputé de 60–70 % | Démarches parallèles dès An 1, consultant réglementaire |
| ENVF-FTLV accélère sa digitalisation (2028+) | Moyenne | **Élevé** — concurrent institutionnel avec crédibilité académique | Position établie avant 2028, différenciation IA + bilinguisme |
| Churn trop élevé (> 20 %/an) | Moyenne | **Moyen** — viabilité repoussée | Couche référence quotidienne (IA) pour réduire le churn, NPS > 40 |
| Sous-estimation des coûts de production de contenu | Élevée | **Moyen** — timeline repoussée de 12–18 mois | Budget de contingence 30 %, priorisation des spécialités à fort ROI |

---

## 9. Questions ouvertes Galaxy

| # | Question | Statut | Décideur |
|---|---|---|---|
| 1 | Quel est le budget total disponible pour la vision Galaxy (5 ans) ? | **À résoudre en priorité** | David |
| 2 | Les partenariats AFVAC/sociétés savantes sont-ils réalistes ? Quelle rémunération pour les formateurs ? | À explorer | Arnaud + Camille |
| 3 | Faut-il créer une entité juridique distincte pour l'activité commerciale Galaxy (vs. Vet&Go clinique) ? | À décider | David + juridique |
| 4 | Le modèle de tarification B2B (199 €/siège 2–5, 169 €/siège 6–15, 129–149 €/siège 16+) est-il aligné avec les attentes des groupes ? | À valider | Prospection pilote |
| 5 | Qualiopi peut-il être obtenu par Vet&Go directement ou faut-il un organisme de formation dédié ? | À investiguer | Arnaud |
| 6 | Le contenu NL doit-il être produit nativement ou traduit/doublé depuis le FR ? | À décider | Arnaud + Elizabeth |
| 7 | Faut-il un éditeur(trice) en chef pour Galaxy (rôle dédié) ? | À décider | Arnaud + David |
| 8 | Quel est le seuil de go/no-go entre niche et Galaxy ? (ex : « Si 200 abonnés et NPS > 40 en An 1, on lance Galaxy ») | **À définir** | David + Arnaud |

---

## Annexe A : Séquencement Galaxy

```
Phase 1 (M0–12) ─────────────────────────┐
  Fondation urgence                       │  Stack technique
  (identique PRD niche)                   │  Cursus urgence
  3 spécialités                           │  Quiz + PDF
                                          │  Dashboard manager
             Phase 2 (M6–18) ─────────────┤──────────────────┐
             Certification +              │  + Anesthésie     │
             premières extensions          │  + Imagerie       │
             6 spécialités                │  + Dentisterie    │
                                          │                   │
                      Phase 3 (M12–24) ───┤──────────────────┤
                      IA clinique +       │  RAG transversal  │
                      expansion           │  + 4 spécialités  │
                      10 spécialités      │  Carte compétences│
                                          │                   │
                               Phase 4 (M18–30) ─────────────┤
                               Commercialisation              │
                               multi-pays                     │
                               15 spécialités                 │
                                                              │
                                        Phase 5 (M24–48) ────┤
                                        Bible complète        │
                                        + B2B                 │
                                        20+ spécialités       │

Réglementaire (en parallèle) ────────────────────────────────┘
  Ordre belge (M0–6)
  CFCV + Qualiopi France (M0–12)
  SVS Suisse (M6–12)
  CKRD Pays-Bas (M12–18)
  Partenariats AFVAC/GEUR (M6–18)
```

## Annexe B : Documents de référence

| Document | Contenu | Fichier |
|---|---|---|
| Market Sizing Galaxy | TAM/SAM/SOM multi-spécialités, 5 pays, 5 ans | `galaxy/market-sizing-galaxy.md` |
| Competitor Analysis Galaxy | 5 concurrents directs, matrice positionnement, différenciation | `galaxy/competitor-analysis-galaxy.md` |
| PRD niche urgence | PRD v2 original (fondation de Galaxy) | `prd-myvetandgo.md` |
| Deep Market Research v2 | Analyse complète par pays, spécialités blue ocean, benchmarks tarifaires | `docs/deep-market-research-v2.md` |
| Architecture niche | Architecture technique v2 (base de Galaxy) | `architecture-myvetandgo.md` |

---

*PRD Galaxy v1 — avril 2026. Ce document définit la vision ambitieuse « Galaxy » de My Vet&Go. La trajectoire niche → Galaxy est conditionnée au succès de la Phase 1 (urgence) et à la validation du modèle (seuil go/no-go à définir, question ouverte #8).*
