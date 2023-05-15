/*
  Warnings:

  - You are about to drop the `Street` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "Street";

-- CreateTable
CREATE TABLE "street" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "from" TEXT,
    "to" TEXT,
    "width" TEXT,
    "length" TEXT,
    "date" TEXT,
    "noncity" TEXT,
    "unacceptedlength" TEXT,
    "area" INTEGER DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "street_pkey" PRIMARY KEY ("id")
);
