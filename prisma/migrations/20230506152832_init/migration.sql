-- CreateTable
CREATE TABLE "EvLocations" (
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

    CONSTRAINT "EvLocations_pkey" PRIMARY KEY ("id")
);
