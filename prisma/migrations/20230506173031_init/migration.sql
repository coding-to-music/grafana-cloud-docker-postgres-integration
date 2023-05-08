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
  - Added the required column `city` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fuel_type_code` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `latitude` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `longitude` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `state` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `station_name` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `status_code` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `street_address` to the `ev_locations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `zip` to the `ev_locations` table without a default value. This is not possible if the table is not empty.

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
ADD COLUMN     "access_days_time" TEXT,
ADD COLUMN     "city" TEXT NOT NULL,
ADD COLUMN     "facility_type" TEXT,
ADD COLUMN     "fuel_type_code" TEXT NOT NULL,
ADD COLUMN     "groups_with_access_code" TEXT,
ADD COLUMN     "latitude" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "longitude" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "plus4" TEXT,
ADD COLUMN     "state" TEXT NOT NULL,
ADD COLUMN     "station_name" TEXT NOT NULL,
ADD COLUMN     "status_code" TEXT NOT NULL,
ADD COLUMN     "street_address" TEXT NOT NULL,
ADD COLUMN     "zip" TEXT NOT NULL;
