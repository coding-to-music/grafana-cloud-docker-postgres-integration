/*
  Warnings:

  - You are about to drop the column `access_days_time` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `city` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `facility_type` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `fuel_type_code` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `groups_with_access_code` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `latitude` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `longitude` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `plus4` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `state` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `station_name` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `status_code` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `street_address` on the `ev_locations` table. All the data in the column will be lost.
  - You are about to drop the column `zip` on the `ev_locations` table. All the data in the column will be lost.
  - Added the required column `City` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Fuel_Type_Code` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Latitude` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Longitude` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `State` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Station_Name` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Status_Code` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Street_Address` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ZIP` to the `ev_locations` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ev_locations" DROP COLUMN "access_days_time",
DROP COLUMN "city",
DROP COLUMN "facility_type",
DROP COLUMN "fuel_type_code",
DROP COLUMN "groups_with_access_code",
DROP COLUMN "latitude",
DROP COLUMN "longitude",
DROP COLUMN "plus4",
DROP COLUMN "state",
DROP COLUMN "station_name",
DROP COLUMN "status_code",
DROP COLUMN "street_address",
DROP COLUMN "zip",
ADD COLUMN     "Access_Days_Time" TEXT,
ADD COLUMN     "City" TEXT NOT NULL,
ADD COLUMN     "Facility_Type" TEXT,
ADD COLUMN     "Fuel_Type_Code" TEXT NOT NULL,
ADD COLUMN     "Groups_With_Access_Code" TEXT,
ADD COLUMN     "Latitude" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "Longitude" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "Plus4" TEXT,
ADD COLUMN     "State" TEXT NOT NULL,
ADD COLUMN     "Station_Name" TEXT NOT NULL,
ADD COLUMN     "Status_Code" TEXT NOT NULL,
ADD COLUMN     "Street_Address" TEXT NOT NULL,
ADD COLUMN     "ZIP" TEXT NOT NULL;
