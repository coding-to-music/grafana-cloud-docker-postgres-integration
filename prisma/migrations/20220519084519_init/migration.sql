-- CreateTable
CREATE TABLE "Street" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "from" TEXT,
    "to" TEXT,
    "width" INTEGER,
    "length" INTEGER,
    "date" TEXT,
    "noncity" TEXT,
    "unnacceptedlength" TEXT,

    CONSTRAINT "Street_pkey" PRIMARY KEY ("id")
);
