CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "description" text, "created_at" datetime, "updated_at" datetime, "picture_file_name" varchar(255), "picture_content_type" varchar(255), "picture_file_size" integer, "picture_updated_at" datetime, "aperture" varchar(255), "comment" varchar(255), "create_date" datetime, "date_time_original" datetime, "device_attributes" varchar(255), "exif_tool_version" varchar(255), "exif_version" varchar(255), "exposure_time" varchar(255), "flash" varchar(255), "focal_length" varchar(255), "image_size" varchar(255), "keywords" varchar(255), "make" varchar(255), "model" varchar(255), "modify_date" datetime, "orientation" varchar(255), "shutter_speed" varchar(255));
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20090317005522');

INSERT INTO schema_migrations (version) VALUES ('20090317013840');

INSERT INTO schema_migrations (version) VALUES ('20090326012036');