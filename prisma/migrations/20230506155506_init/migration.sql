/*
  Warnings:

  - You are about to drop the `EvLocations` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "EvLocations";

-- CreateTable
CREATE TABLE "ev_locations" (
    "id" SERIAL NOT NULL,
    "Fuel_Type_Code" TEXT NOT NULL,
    "Station_Name" TEXT NOT NULL,
    "Street_Address" TEXT NOT NULL,
    "City" TEXT NOT NULL,
    "State" TEXT NOT NULL,
    "ZIP" TEXT NOT NULL,
    "Plus4" TEXT,
    "Status_Code" TEXT NOT NULL,
    "Groups_With_Access_Code" TEXT,
    "Access_Days_Time" TEXT,
    "Latitude" DOUBLE PRECISION NOT NULL,
    "Longitude" DOUBLE PRECISION NOT NULL,
    "Facility_Type" TEXT,

    CONSTRAINT "ev_locations_pkey" PRIMARY KEY ("id")
);
