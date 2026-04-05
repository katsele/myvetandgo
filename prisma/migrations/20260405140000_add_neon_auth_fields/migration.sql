-- AlterTable: Add Neon Auth fields to User
ALTER TABLE "User" ADD COLUMN "neonAuthId" TEXT;
ALTER TABLE "User" ADD COLUMN "onboarded" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "User" ALTER COLUMN "firstName" SET DEFAULT '';
ALTER TABLE "User" ALTER COLUMN "lastName" SET DEFAULT '';

-- CreateIndex
CREATE UNIQUE INDEX "User_neonAuthId_key" ON "User"("neonAuthId");
CREATE INDEX "User_neonAuthId_idx" ON "User"("neonAuthId");
