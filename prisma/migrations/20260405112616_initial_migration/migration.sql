-- CreateExtension
CREATE EXTENSION IF NOT EXISTS "vector";

-- CreateEnum
CREATE TYPE "Profile" AS ENUM ('VET', 'ASV', 'WELLBEING');

-- CreateEnum
CREATE TYPE "CurriculumLevel" AS ENUM ('BEGINNER', 'INTERMEDIATE', 'ADVANCED');

-- CreateEnum
CREATE TYPE "CurriculumType" AS ENUM ('SYSTEM', 'TRANSVERSAL', 'PROCEDURAL');

-- CreateEnum
CREATE TYPE "OrgType" AS ENUM ('INTERNAL', 'EXTERNAL', 'CLINIC', 'GROUP');

-- CreateEnum
CREATE TYPE "Country" AS ENUM ('BE', 'FR', 'LU', 'NL', 'CH');

-- CreateEnum
CREATE TYPE "Language" AS ENUM ('FR', 'NL');

-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('VET', 'ASV', 'MANAGER', 'GROUP_ADMIN', 'CONTRIBUTOR', 'ADMIN');

-- CreateEnum
CREATE TYPE "SubscriptionPlan" AS ENUM ('INDIVIDUAL_MONTHLY', 'INDIVIDUAL_ANNUAL', 'CLINIC_ANNUAL', 'GROUP_ANNUAL');

-- CreateEnum
CREATE TYPE "SubStatus" AS ENUM ('TRIALING', 'ACTIVE', 'PAST_DUE', 'CANCELED', 'PAUSED');

-- CreateEnum
CREATE TYPE "ContribRole" AS ENUM ('PRESENTER', 'REVIEWER', 'QUIZ_AUTHOR');

-- CreateEnum
CREATE TYPE "QuestionType" AS ENUM ('SINGLE_CHOICE', 'MULTIPLE_CHOICE');

-- CreateTable
CREATE TABLE "Specialty" (
    "id" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "nameFr" TEXT NOT NULL,
    "nameNl" TEXT NOT NULL,
    "descriptionFr" TEXT,
    "descriptionNl" TEXT,
    "iconUrl" TEXT,
    "wave" INTEGER NOT NULL DEFAULT 1,
    "isActive" BOOLEAN NOT NULL DEFAULT false,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Specialty_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Curriculum" (
    "id" TEXT NOT NULL,
    "specialtyId" TEXT NOT NULL,
    "nameFr" TEXT NOT NULL,
    "nameNl" TEXT NOT NULL,
    "descriptionFr" TEXT,
    "descriptionNl" TEXT,
    "profile" "Profile" NOT NULL,
    "type" "CurriculumType" NOT NULL,
    "level" "CurriculumLevel" NOT NULL DEFAULT 'BEGINNER',
    "durationHours" DOUBLE PRECISION,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Curriculum_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Video" (
    "id" TEXT NOT NULL,
    "vimeoId" TEXT NOT NULL,
    "titleFr" TEXT NOT NULL,
    "titleNl" TEXT NOT NULL,
    "descriptionFr" TEXT,
    "descriptionNl" TEXT,
    "durationMin" INTEGER NOT NULL,
    "thumbnailUrl" TEXT,
    "publishedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Video_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CurriculumVideo" (
    "id" TEXT NOT NULL,
    "curriculumId" TEXT NOT NULL,
    "videoId" TEXT NOT NULL,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "CurriculumVideo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Chapter" (
    "id" TEXT NOT NULL,
    "videoId" TEXT NOT NULL,
    "titleFr" TEXT NOT NULL,
    "titleNl" TEXT NOT NULL,
    "startTimeSec" INTEGER NOT NULL,
    "endTimeSec" INTEGER NOT NULL,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Chapter_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Transcript" (
    "id" TEXT NOT NULL,
    "videoId" TEXT NOT NULL,
    "language" "Language" NOT NULL,
    "vttUrl" TEXT,
    "content" TEXT,

    CONSTRAINT "Transcript_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TranscriptSegment" (
    "id" TEXT NOT NULL,
    "transcriptId" TEXT NOT NULL,
    "startSec" INTEGER NOT NULL,
    "endSec" INTEGER NOT NULL,
    "text" TEXT NOT NULL,
    "embedding" vector(1536),

    CONSTRAINT "TranscriptSegment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Quiz" (
    "id" TEXT NOT NULL,
    "videoId" TEXT NOT NULL,
    "titleFr" TEXT NOT NULL,
    "titleNl" TEXT NOT NULL,
    "passingScore" INTEGER NOT NULL DEFAULT 80,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Quiz_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Question" (
    "id" TEXT NOT NULL,
    "quizId" TEXT NOT NULL,
    "questionFr" TEXT NOT NULL,
    "questionNl" TEXT NOT NULL,
    "questionType" "QuestionType" NOT NULL DEFAULT 'SINGLE_CHOICE',
    "sortOrder" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Question_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QuestionOption" (
    "id" TEXT NOT NULL,
    "questionId" TEXT NOT NULL,
    "labelFr" TEXT NOT NULL,
    "labelNl" TEXT NOT NULL,
    "isCorrect" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "QuestionOption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QuizAttempt" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "quizId" TEXT NOT NULL,
    "score" DOUBLE PRECISION NOT NULL,
    "passed" BOOLEAN NOT NULL,
    "cePointsAwarded" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "completedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "QuizAttempt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CurriculumProgress" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "curriculumId" TEXT NOT NULL,
    "completedVideos" INTEGER NOT NULL DEFAULT 0,
    "totalVideos" INTEGER NOT NULL DEFAULT 0,
    "lastAccessedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMP(3),

    CONSTRAINT "CurriculumProgress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpecialtyCertificate" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "curriculumId" TEXT NOT NULL,
    "pdfUrl" TEXT NOT NULL,
    "issuedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SpecialtyCertificate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Organization" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" "OrgType" NOT NULL,
    "slug" TEXT NOT NULL,
    "country" "Country" NOT NULL DEFAULT 'BE',
    "parentId" TEXT,
    "maxSeats" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Organization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "language" "Language" NOT NULL DEFAULT 'FR',
    "role" "UserRole" NOT NULL DEFAULT 'VET',
    "orderNumber" TEXT,
    "country" "Country" NOT NULL DEFAULT 'BE',
    "organizationId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deactivatedAt" TIMESTAMP(3),

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Subscription" (
    "id" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "stripeCustomerId" TEXT NOT NULL,
    "stripeSubId" TEXT,
    "plan" "SubscriptionPlan" NOT NULL,
    "status" "SubStatus" NOT NULL DEFAULT 'TRIALING',
    "seats" INTEGER NOT NULL DEFAULT 1,
    "pricePerSeat" INTEGER NOT NULL,
    "currentPeriodEnd" TIMESTAMP(3) NOT NULL,
    "cancelAtPeriodEnd" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Subscription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contributor" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "title" TEXT,
    "specialties" TEXT[],
    "bio" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Contributor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VideoContribution" (
    "id" TEXT NOT NULL,
    "videoId" TEXT NOT NULL,
    "contributorId" TEXT NOT NULL,
    "role" "ContribRole" NOT NULL DEFAULT 'PRESENTER',

    CONSTRAINT "VideoContribution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CeAccreditation" (
    "id" TEXT NOT NULL,
    "country" "Country" NOT NULL,
    "bodyName" TEXT NOT NULL,
    "accreditationId" TEXT,
    "pointsPerHour" DOUBLE PRECISION NOT NULL,
    "maxElearningPct" DOUBLE PRECISION NOT NULL DEFAULT 100,
    "validFrom" TIMESTAMP(3) NOT NULL,
    "validTo" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CeAccreditation_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Specialty_slug_key" ON "Specialty"("slug");

-- CreateIndex
CREATE INDEX "Curriculum_specialtyId_idx" ON "Curriculum"("specialtyId");

-- CreateIndex
CREATE UNIQUE INDEX "Video_vimeoId_key" ON "Video"("vimeoId");

-- CreateIndex
CREATE INDEX "CurriculumVideo_videoId_idx" ON "CurriculumVideo"("videoId");

-- CreateIndex
CREATE UNIQUE INDEX "CurriculumVideo_curriculumId_videoId_key" ON "CurriculumVideo"("curriculumId", "videoId");

-- CreateIndex
CREATE INDEX "Chapter_videoId_idx" ON "Chapter"("videoId");

-- CreateIndex
CREATE UNIQUE INDEX "Transcript_videoId_language_key" ON "Transcript"("videoId", "language");

-- CreateIndex
CREATE INDEX "TranscriptSegment_transcriptId_idx" ON "TranscriptSegment"("transcriptId");

-- CreateIndex
CREATE INDEX "Quiz_videoId_idx" ON "Quiz"("videoId");

-- CreateIndex
CREATE INDEX "Question_quizId_idx" ON "Question"("quizId");

-- CreateIndex
CREATE INDEX "QuestionOption_questionId_idx" ON "QuestionOption"("questionId");

-- CreateIndex
CREATE INDEX "QuizAttempt_userId_idx" ON "QuizAttempt"("userId");

-- CreateIndex
CREATE INDEX "QuizAttempt_quizId_idx" ON "QuizAttempt"("quizId");

-- CreateIndex
CREATE UNIQUE INDEX "CurriculumProgress_userId_curriculumId_key" ON "CurriculumProgress"("userId", "curriculumId");

-- CreateIndex
CREATE INDEX "SpecialtyCertificate_userId_idx" ON "SpecialtyCertificate"("userId");

-- CreateIndex
CREATE INDEX "SpecialtyCertificate_curriculumId_idx" ON "SpecialtyCertificate"("curriculumId");

-- CreateIndex
CREATE UNIQUE INDEX "Organization_slug_key" ON "Organization"("slug");

-- CreateIndex
CREATE INDEX "Organization_parentId_idx" ON "Organization"("parentId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "User_organizationId_idx" ON "User"("organizationId");

-- CreateIndex
CREATE UNIQUE INDEX "Subscription_organizationId_key" ON "Subscription"("organizationId");

-- CreateIndex
CREATE UNIQUE INDEX "Subscription_stripeCustomerId_key" ON "Subscription"("stripeCustomerId");

-- CreateIndex
CREATE UNIQUE INDEX "Subscription_stripeSubId_key" ON "Subscription"("stripeSubId");

-- CreateIndex
CREATE UNIQUE INDEX "Contributor_userId_key" ON "Contributor"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Contributor_email_key" ON "Contributor"("email");

-- CreateIndex
CREATE INDEX "VideoContribution_videoId_idx" ON "VideoContribution"("videoId");

-- CreateIndex
CREATE INDEX "VideoContribution_contributorId_idx" ON "VideoContribution"("contributorId");

-- CreateIndex
CREATE UNIQUE INDEX "CeAccreditation_country_bodyName_key" ON "CeAccreditation"("country", "bodyName");

-- AddForeignKey
ALTER TABLE "Curriculum" ADD CONSTRAINT "Curriculum_specialtyId_fkey" FOREIGN KEY ("specialtyId") REFERENCES "Specialty"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CurriculumVideo" ADD CONSTRAINT "CurriculumVideo_curriculumId_fkey" FOREIGN KEY ("curriculumId") REFERENCES "Curriculum"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CurriculumVideo" ADD CONSTRAINT "CurriculumVideo_videoId_fkey" FOREIGN KEY ("videoId") REFERENCES "Video"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Chapter" ADD CONSTRAINT "Chapter_videoId_fkey" FOREIGN KEY ("videoId") REFERENCES "Video"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transcript" ADD CONSTRAINT "Transcript_videoId_fkey" FOREIGN KEY ("videoId") REFERENCES "Video"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TranscriptSegment" ADD CONSTRAINT "TranscriptSegment_transcriptId_fkey" FOREIGN KEY ("transcriptId") REFERENCES "Transcript"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Quiz" ADD CONSTRAINT "Quiz_videoId_fkey" FOREIGN KEY ("videoId") REFERENCES "Video"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Question" ADD CONSTRAINT "Question_quizId_fkey" FOREIGN KEY ("quizId") REFERENCES "Quiz"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuestionOption" ADD CONSTRAINT "QuestionOption_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "Question"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuizAttempt" ADD CONSTRAINT "QuizAttempt_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuizAttempt" ADD CONSTRAINT "QuizAttempt_quizId_fkey" FOREIGN KEY ("quizId") REFERENCES "Quiz"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CurriculumProgress" ADD CONSTRAINT "CurriculumProgress_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CurriculumProgress" ADD CONSTRAINT "CurriculumProgress_curriculumId_fkey" FOREIGN KEY ("curriculumId") REFERENCES "Curriculum"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpecialtyCertificate" ADD CONSTRAINT "SpecialtyCertificate_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpecialtyCertificate" ADD CONSTRAINT "SpecialtyCertificate_curriculumId_fkey" FOREIGN KEY ("curriculumId") REFERENCES "Curriculum"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Organization" ADD CONSTRAINT "Organization_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Organization"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Subscription" ADD CONSTRAINT "Subscription_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contributor" ADD CONSTRAINT "Contributor_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VideoContribution" ADD CONSTRAINT "VideoContribution_videoId_fkey" FOREIGN KEY ("videoId") REFERENCES "Video"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VideoContribution" ADD CONSTRAINT "VideoContribution_contributorId_fkey" FOREIGN KEY ("contributorId") REFERENCES "Contributor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
