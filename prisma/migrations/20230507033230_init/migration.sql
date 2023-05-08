/*
  Warnings:

  - You are about to drop the column `Access_Days_Time` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `City` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `Facility_Type` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `Fuel_Type_Code` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `Groups_With_Access_Code` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `Latitude` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `Longitude` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `Plus4` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `State` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `Station_Name` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `Status_Code` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `Street_Address` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `ZIP` on the `ev_locations` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "ev_locations" DROP COLUMN "Access_Days_Time",
DROP COLUMN "City",
DROP COLUMN "Facility_Type",
DROP COLUMN "Fuel_Type_Code",
DROP COLUMN "Groups_With_Access_Code",
DROP COLUMN "Latitude",
DROP COLUMN "Longitude",
DROP COLUMN "Plus4",
DROP COLUMN "State",
DROP COLUMN "Station_Name",
DROP COLUMN "Status_Code",
DROP COLUMN "Street_Address",
DROP COLUMN "ZIP",
ADD COLUMN     "access_days_time" VARCHAR(255),
ADD COLUMN     "city" VARCHAR(100),
ADD COLUMN     "facility_type" VARCHAR(100),
ADD COLUMN     "fuel_type_code" VARCHAR(100),
ADD COLUMN     "groups_with_access_code" VARCHAR(255),
ADD COLUMN     "latitude" DECIMAL(20,10),
ADD COLUMN     "longitude" DECIMAL(20,10),
ADD COLUMN     "plus4" VARCHAR(20),
ADD COLUMN     "state" VARCHAR(100),
ADD COLUMN     "station_name" VARCHAR(255),
ADD COLUMN     "status_code" VARCHAR(20),
ADD COLUMN     "street_address" VARCHAR(255),
ADD COLUMN     "zip" VARCHAR(20);
