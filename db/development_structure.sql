CREATE TABLE "buckets" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "title" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "invites" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "sender_id" integer, "recipient_email" varchar(255), "token" varchar(255), "sent_at" datetime, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "description" text, "created_at" datetime, "updated_at" datetime, "picture_file_name" varchar(255), "picture_content_type" varchar(255), "picture_file_size" integer, "picture_updated_at" datetime, "aperture" varchar(255), "comment" varchar(255), "create_date" varchar(255), "date_time_original" varchar(255), "device_attributes" varchar(255), "exif_tool_version" varchar(255), "exif_version" varchar(255), "exposure_time" varchar(255), "flash" varchar(255), "focal_length" varchar(255), "image_size" varchar(255), "keywords" varchar(255), "make" varchar(255), "model" varchar(255), "modify_date" varchar(255), "orientation" varchar(255), "shutter_speed" varchar(255), "user_id" integer, "exif_image_length" varchar(255), "exif_image_width" varchar(255), "x_resolution" varchar(255), "y_resolution" varchar(255), "y_cb_cr_positioning" varchar(255), "picture_remote_url" varchar(255), "bucket_id" integer);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "taggings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "tag_id" integer, "taggable_type" varchar(255) DEFAULT '', "taggable_id" integer);
CREATE TABLE "tags" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) DEFAULT '', "kind" varchar(255) DEFAULT '');
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "login" varchar(255) NOT NULL, "email" varchar(255) NOT NULL, "crypted_password" varchar(255) NOT NULL, "password_salt" varchar(255) NOT NULL, "persistence_token" varchar(255) NOT NULL, "single_access_token" varchar(255) NOT NULL, "perishable_token" varchar(255) NOT NULL, "login_count" integer DEFAULT 0 NOT NULL, "failed_login_count" integer DEFAULT 0 NOT NULL, "last_request_at" datetime, "current_login_at" datetime, "last_login_at" datetime, "current_login_ip" varchar(255), "last_login_ip" varchar(255), "created_at" datetime, "updated_at" datetime, "active" boolean DEFAULT 'f' NOT NULL, "invite_id" integer, "invite_limit" integer DEFAULT 0 NOT NULL);
CREATE INDEX "index_taggings_on_tag_id" ON "taggings" ("tag_id");
CREATE INDEX "index_taggings_on_taggable_id_and_taggable_type" ON "taggings" ("taggable_id", "taggable_type");
CREATE INDEX "index_tags_on_name_and_kind" ON "tags" ("name", "kind");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20090317005522');

INSERT INTO schema_migrations (version) VALUES ('20090317013840');

INSERT INTO schema_migrations (version) VALUES ('20090326012036');

INSERT INTO schema_migrations (version) VALUES ('20090331023141');

INSERT INTO schema_migrations (version) VALUES ('20090404010603');

INSERT INTO schema_migrations (version) VALUES ('20090405171438');

INSERT INTO schema_migrations (version) VALUES ('20090408003557');

INSERT INTO schema_migrations (version) VALUES ('20090419170859');

INSERT INTO schema_migrations (version) VALUES ('20090420210639');

INSERT INTO schema_migrations (version) VALUES ('20090420215354');

INSERT INTO schema_migrations (version) VALUES ('20090424231555');