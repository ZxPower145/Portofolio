-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."auth_group" (
    "id" int4 NOT NULL,
    "name" varchar(150) NOT NULL,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."auth_group_permissions" (
    "id" int8 NOT NULL,
    "group_id" int4 NOT NULL,
    "permission_id" int4 NOT NULL,
    CONSTRAINT "auth_group_permissions_group_id_b120cbf9_fk_auth_group_id" FOREIGN KEY ("group_id") REFERENCES "public"."auth_group"("id"),
    CONSTRAINT "auth_group_permissio_permission_id_84c5c92e_fk_auth_perm" FOREIGN KEY ("permission_id") REFERENCES "public"."auth_permission"("id"),
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."auth_permission" (
    "id" int4 NOT NULL,
    "name" varchar(255) NOT NULL,
    "content_type_id" int4 NOT NULL,
    "codename" varchar(100) NOT NULL,
    CONSTRAINT "auth_permission_content_type_id_2f476e4b_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "public"."django_content_type"("id"),
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."auth_user" (
    "id" int4 NOT NULL,
    "password" varchar(128) NOT NULL,
    "last_login" timestamptz,
    "is_superuser" bool NOT NULL,
    "username" varchar(150) NOT NULL,
    "first_name" varchar(150) NOT NULL,
    "last_name" varchar(150) NOT NULL,
    "email" varchar(254) NOT NULL,
    "is_staff" bool NOT NULL,
    "is_active" bool NOT NULL,
    "date_joined" timestamptz NOT NULL,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."auth_user_groups" (
    "id" int8 NOT NULL,
    "user_id" int4 NOT NULL,
    "group_id" int4 NOT NULL,
    CONSTRAINT "auth_user_groups_user_id_6a12ed8b_fk_auth_user_id" FOREIGN KEY ("user_id") REFERENCES "public"."auth_user"("id"),
    CONSTRAINT "auth_user_groups_group_id_97559544_fk_auth_group_id" FOREIGN KEY ("group_id") REFERENCES "public"."auth_group"("id"),
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."auth_user_user_permissions" (
    "id" int8 NOT NULL,
    "user_id" int4 NOT NULL,
    "permission_id" int4 NOT NULL,
    CONSTRAINT "auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id" FOREIGN KEY ("user_id") REFERENCES "public"."auth_user"("id"),
    CONSTRAINT "auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm" FOREIGN KEY ("permission_id") REFERENCES "public"."auth_permission"("id"),
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."authtoken_token" (
    "key" varchar(40) NOT NULL,
    "created" timestamptz NOT NULL,
    "user_id" int4 NOT NULL,
    CONSTRAINT "authtoken_token_user_id_35299eff_fk_auth_user_id" FOREIGN KEY ("user_id") REFERENCES "public"."auth_user"("id"),
    PRIMARY KEY ("key")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."django_admin_log" (
    "id" int4 NOT NULL,
    "action_time" timestamptz NOT NULL,
    "object_id" text,
    "object_repr" varchar(200) NOT NULL,
    "action_flag" int2 NOT NULL,
    "change_message" text NOT NULL,
    "content_type_id" int4,
    "user_id" int4 NOT NULL,
    CONSTRAINT "django_admin_log_content_type_id_c4bce8eb_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "public"."django_content_type"("id"),
    CONSTRAINT "django_admin_log_user_id_c564eba6_fk_auth_user_id" FOREIGN KEY ("user_id") REFERENCES "public"."auth_user"("id"),
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."django_content_type" (
    "id" int4 NOT NULL,
    "app_label" varchar(100) NOT NULL,
    "model" varchar(100) NOT NULL,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."django_migrations" (
    "id" int8 NOT NULL,
    "app" varchar(255) NOT NULL,
    "name" varchar(255) NOT NULL,
    "applied" timestamptz NOT NULL,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."django_session" (
    "session_key" varchar(40) NOT NULL,
    "session_data" text NOT NULL,
    "expire_date" timestamptz NOT NULL,
    PRIMARY KEY ("session_key")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."portofolio_contact" (
    "id" int8 NOT NULL,
    "name" varchar(150),
    "email" varchar(150),
    "message" text,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."portofolio_profile" (
    "id" int8 NOT NULL,
    "primary_bio" text,
    "has_bio" bool NOT NULL,
    "user_id" int4 NOT NULL,
    "secondary_bio" text,
    CONSTRAINT "portofolio_profile_user_id_c3b68113_fk_auth_user_id" FOREIGN KEY ("user_id") REFERENCES "public"."auth_user"("id"),
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."portofolio_projects" (
    "id" int8 NOT NULL,
    "name" varchar(150),
    "slug" varchar(50) NOT NULL,
    "github" varchar(255),
    "hostLink" varchar(255),
    "isHosted" bool NOT NULL,
    "isActive" bool NOT NULL,
    "date_added" timestamptz NOT NULL,
    "date_modified" timestamptz NOT NULL,
    "description" text,
    "category" varchar(50) NOT NULL,
    PRIMARY KEY ("id")
);





INSERT INTO "public"."auth_permission" ("id", "name", "content_type_id", "codename") VALUES
(1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO "public"."auth_permission" ("id", "name", "content_type_id", "codename") VALUES
(2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO "public"."auth_permission" ("id", "name", "content_type_id", "codename") VALUES
(3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO "public"."auth_permission" ("id", "name", "content_type_id", "codename") VALUES
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add projects', 7, 'add_projects'),
(26, 'Can change projects', 7, 'change_projects'),
(27, 'Can delete projects', 7, 'delete_projects'),
(28, 'Can view projects', 7, 'view_projects'),
(29, 'Can add skills', 8, 'add_skills'),
(30, 'Can change skills', 8, 'change_skills'),
(31, 'Can delete skills', 8, 'delete_skills'),
(32, 'Can view skills', 8, 'view_skills'),
(33, 'Can add profile', 9, 'add_profile'),
(34, 'Can change profile', 9, 'change_profile'),
(35, 'Can delete profile', 9, 'delete_profile'),
(36, 'Can view profile', 9, 'view_profile'),
(37, 'Can add Token', 10, 'add_token'),
(38, 'Can change Token', 10, 'change_token'),
(39, 'Can delete Token', 10, 'delete_token'),
(40, 'Can view Token', 10, 'view_token'),
(41, 'Can add token', 11, 'add_tokenproxy'),
(42, 'Can change token', 11, 'change_tokenproxy'),
(43, 'Can delete token', 11, 'delete_tokenproxy'),
(44, 'Can view token', 11, 'view_tokenproxy'),
(45, 'Can add contact', 12, 'add_contact'),
(46, 'Can change contact', 12, 'change_contact'),
(47, 'Can delete contact', 12, 'delete_contact'),
(48, 'Can view contact', 12, 'view_contact');

INSERT INTO "public"."auth_user" ("id", "password", "last_login", "is_superuser", "username", "first_name", "last_name", "email", "is_staff", "is_active", "date_joined") VALUES
(1, 'pbkdf2_sha256$390000$aqNSri4k8qb2pNIVIRB1Uk$jeyVlo0D1WvOq9Mncyj3OUT5bSjI2ERc0emgKy+SOm8=', '2024-01-25 21:29:01.794985+00', 't', 'ZxPower', '', '', 'zxpower@yahoo.com', 't', 't', '2023-11-30 21:03:02.238995+00');








INSERT INTO "public"."django_admin_log" ("id", "action_time", "object_id", "object_repr", "action_flag", "change_message", "content_type_id", "user_id") VALUES
(1, '2023-11-30 21:25:34.818852+00', '1', 'Profile object (1)', 1, '[{"added": {}}]', 9, 1);
INSERT INTO "public"."django_admin_log" ("id", "action_time", "object_id", "object_repr", "action_flag", "change_message", "content_type_id", "user_id") VALUES
(2, '2023-11-30 21:33:38.649008+00', '1', 'Webstore', 1, '[{"added": {}}]', 7, 1);
INSERT INTO "public"."django_admin_log" ("id", "action_time", "object_id", "object_repr", "action_flag", "change_message", "content_type_id", "user_id") VALUES
(3, '2023-11-30 21:34:03.809684+00', '2', 'Camera movement detection', 1, '[{"added": {}}]', 7, 1);
INSERT INTO "public"."django_admin_log" ("id", "action_time", "object_id", "object_repr", "action_flag", "change_message", "content_type_id", "user_id") VALUES
(4, '2023-11-30 21:44:40.348071+00', '1', 'python', 1, '[{"added": {}}]', 8, 1),
(5, '2023-11-30 21:44:58.049107+00', '2', 'javascript', 1, '[{"added": {}}]', 8, 1),
(6, '2023-12-08 13:37:26.88558+00', '1', 'Profile object (1)', 2, '[{"changed": {"fields": ["Secondary bio"]}}]', 9, 1),
(7, '2023-12-08 16:32:10.110294+00', '1', 'Profile object (1)', 2, '[{"changed": {"fields": ["Primary bio", "Secondary bio"]}}]', 9, 1),
(8, '2023-12-12 19:30:23.622008+00', '2', 'Camera movement detection', 3, '', 7, 1),
(9, '2023-12-12 19:31:37.961417+00', '1', 'Webstore', 2, '[{"changed": {"fields": ["Github", "Host link", "Is hosted"]}}]', 7, 1),
(10, '2023-12-12 19:32:38.617245+00', '3', 'The Pig Game', 1, '[{"added": {}}]', 7, 1),
(11, '2023-12-12 19:33:36.690274+00', '4', 'Shoot The Crow', 1, '[{"added": {}}]', 7, 1),
(12, '2023-12-12 19:34:39.459985+00', '5', 'Guess The Number', 1, '[{"added": {}}]', 7, 1),
(13, '2023-12-12 19:37:13.341754+00', '1', 'Django and Vue webstore', 2, '[{"changed": {"fields": ["Title", "Github"]}}]', 7, 1),
(14, '2023-12-12 19:37:53.385096+00', '6', 'Invoice Manager WebApp', 1, '[{"added": {}}]', 7, 1),
(15, '2023-12-12 19:38:16.87591+00', '1', 'Django and Vue WebStore', 2, '[{"changed": {"fields": ["Title"]}}]', 7, 1),
(16, '2023-12-12 19:38:34.47591+00', '7', 'Python Student Management System', 1, '[{"added": {}}]', 7, 1),
(17, '2023-12-12 19:39:06.633026+00', '8', 'Python ChatGPT Gui', 1, '[{"added": {}}]', 7, 1),
(18, '2023-12-12 19:42:03.841436+00', '8', 'Python ChatGPT Gui', 2, '[]', 7, 1),
(19, '2023-12-12 19:50:01.333024+00', '8', 'Python ChatGPT Gui', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(20, '2023-12-12 19:50:51.713262+00', '7', 'Python Student Management System', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(21, '2023-12-12 19:51:40.436376+00', '7', 'Python Student Management System', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(22, '2023-12-12 19:53:36.140431+00', '6', 'Invoice Manager WebApp', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(23, '2023-12-12 19:54:42.650651+00', '5', 'Guess The Number', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(24, '2023-12-12 19:55:17.808938+00', '4', 'Shoot The Crow', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(25, '2023-12-12 19:56:16.96785+00', '3', 'The Pig Game', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(26, '2023-12-12 19:59:13.972083+00', '1', 'Django and Vue WebStore', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(27, '2023-12-14 17:50:21.101779+00', '1', 'Django and Vue WebStore', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(28, '2023-12-20 00:33:24.463788+00', '8', 'Python ChatGPT Gui', 2, '[{"changed": {"fields": ["Category"]}}]', 7, 1),
(29, '2023-12-20 00:34:42.373419+00', '7', 'Python Student Management System', 2, '[{"changed": {"fields": ["Category"]}}]', 7, 1),
(30, '2023-12-20 00:34:55.370074+00', '6', 'Invoice Manager WebApp', 2, '[{"changed": {"fields": ["Category"]}}]', 7, 1),
(31, '2023-12-20 00:35:09.817739+00', '5', 'Guess The Number', 2, '[]', 7, 1),
(32, '2023-12-20 00:35:27.04238+00', '1', 'Django and Vue WebStore', 2, '[{"changed": {"fields": ["Category"]}}]', 7, 1),
(33, '2023-12-20 00:36:26.663148+00', '3', 'The Pig Game', 2, '[{"changed": {"fields": ["Category"]}}]', 7, 1),
(34, '2023-12-20 00:36:52.782793+00', '5', 'Guess The Number', 2, '[{"changed": {"fields": ["Category"]}}]', 7, 1),
(35, '2023-12-20 00:37:06.077472+00', '4', 'Shoot The Crow', 2, '[{"changed": {"fields": ["Category"]}}]', 7, 1),
(36, '2024-01-27 22:00:09.917168+00', '5', 'Guess The Number', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(37, '2024-01-27 22:09:01.626207+00', '1', 'Profile object (1)', 2, '[{"changed": {"fields": ["Primary bio"]}}]', 9, 1),
(38, '2024-01-27 22:09:56.406094+00', '1', 'Profile object (1)', 2, '[{"changed": {"fields": ["Primary bio"]}}]', 9, 1),
(39, '2024-01-27 22:10:45.962554+00', '1', 'Profile object (1)', 2, '[{"changed": {"fields": ["Primary bio"]}}]', 9, 1),
(40, '2024-01-27 22:11:55.039843+00', '1', 'Profile object (1)', 2, '[{"changed": {"fields": ["Primary bio"]}}]', 9, 1),
(41, '2024-01-27 22:16:59.916218+00', '1', 'Profile object (1)', 2, '[{"changed": {"fields": ["Primary bio"]}}]', 9, 1),
(42, '2024-01-27 22:17:51.432318+00', '1', 'Profile object (1)', 2, '[{"changed": {"fields": ["Primary bio"]}}]', 9, 1),
(43, '2024-01-27 22:18:33.921937+00', '1', 'Profile object (1)', 2, '[{"changed": {"fields": ["Primary bio", "Secondary bio"]}}]', 9, 1),
(44, '2024-01-27 22:20:43.200728+00', '1', 'Django and Vue WebStore', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(45, '2024-01-27 22:21:21.665283+00', '3', 'The Pig Game', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(46, '2024-01-27 22:22:31.274446+00', '5', 'Guess The Number', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(47, '2024-01-27 22:23:15.207788+00', '6', 'Invoice Manager WebApp', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(48, '2024-01-27 22:23:30.89191+00', '7', 'Python Student Management System', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(49, '2024-01-27 23:28:31.143358+00', '5', 'Guess The Number', 2, '[{"changed": {"fields": ["Slug"]}}]', 7, 1),
(50, '2024-01-27 23:30:32.855322+00', '4', 'Shoot The Crow', 2, '[{"changed": {"fields": ["Slug", "Description"]}}]', 7, 1),
(51, '2024-01-27 23:56:13.12864+00', '9', 'Tic Tac Toe', 1, '[{"added": {}}]', 7, 1),
(52, '2024-01-27 23:59:59.823077+00', '9', 'Tic Tac Toe', 2, '[{"changed": {"fields": ["Github"]}}]', 7, 1),
(53, '2024-01-28 00:01:42.265633+00', '9', 'Tic Tac Toe', 2, '[{"changed": {"fields": ["Github"]}}]', 7, 1),
(54, '2024-01-28 00:52:27.716644+00', '7', 'Python Student Management System', 2, '[]', 7, 1),
(55, '2024-01-28 20:24:16.128314+00', '45', 'Contact object (45)', 3, '', 12, 1),
(56, '2024-01-28 20:24:16.327538+00', '44', 'Contact object (44)', 3, '', 12, 1),
(57, '2024-01-28 20:24:16.526496+00', '43', 'Contact object (43)', 3, '', 12, 1),
(58, '2024-01-28 20:24:16.725192+00', '42', 'Contact object (42)', 3, '', 12, 1),
(59, '2024-01-28 20:24:16.924323+00', '41', 'Contact object (41)', 3, '', 12, 1),
(60, '2024-01-28 20:24:17.122356+00', '40', 'Contact object (40)', 3, '', 12, 1),
(61, '2024-01-28 20:24:17.320929+00', '39', 'Contact object (39)', 3, '', 12, 1),
(62, '2024-01-28 20:24:17.519174+00', '38', 'Contact object (38)', 3, '', 12, 1),
(63, '2024-01-28 20:24:17.71775+00', '37', 'Contact object (37)', 3, '', 12, 1),
(64, '2024-01-28 20:24:17.915522+00', '36', 'Contact object (36)', 3, '', 12, 1),
(65, '2024-01-28 20:24:18.114413+00', '35', 'Contact object (35)', 3, '', 12, 1),
(66, '2024-01-28 20:24:18.315586+00', '34', 'Contact object (34)', 3, '', 12, 1),
(67, '2024-01-28 20:24:18.514106+00', '33', 'Contact object (33)', 3, '', 12, 1),
(68, '2024-01-28 20:24:18.713132+00', '32', 'Contact object (32)', 3, '', 12, 1),
(69, '2024-01-28 20:24:18.911753+00', '31', 'Contact object (31)', 3, '', 12, 1),
(70, '2024-01-28 20:24:19.110324+00', '30', 'Contact object (30)', 3, '', 12, 1),
(71, '2024-01-28 20:24:19.31107+00', '29', 'Contact object (29)', 3, '', 12, 1),
(72, '2024-01-28 20:24:19.510611+00', '28', 'Contact object (28)', 3, '', 12, 1),
(73, '2024-01-28 20:24:19.708273+00', '27', 'Contact object (27)', 3, '', 12, 1),
(74, '2024-01-28 20:24:19.907521+00', '26', 'Contact object (26)', 3, '', 12, 1),
(75, '2024-01-28 20:24:20.105546+00', '25', 'Contact object (25)', 3, '', 12, 1),
(76, '2024-01-28 20:24:20.304482+00', '24', 'Contact object (24)', 3, '', 12, 1),
(77, '2024-01-28 20:24:20.502093+00', '23', 'Contact object (23)', 3, '', 12, 1),
(78, '2024-01-28 20:24:20.701564+00', '22', 'Contact object (22)', 3, '', 12, 1),
(79, '2024-01-28 20:24:20.904447+00', '21', 'Contact object (21)', 3, '', 12, 1),
(80, '2024-01-28 20:24:21.102991+00', '20', 'Contact object (20)', 3, '', 12, 1),
(81, '2024-01-28 20:24:21.301043+00', '19', 'Contact object (19)', 3, '', 12, 1),
(82, '2024-01-28 20:24:21.499676+00', '18', 'Contact object (18)', 3, '', 12, 1),
(83, '2024-01-28 20:24:21.698621+00', '17', 'Contact object (17)', 3, '', 12, 1),
(84, '2024-01-28 20:24:21.896664+00', '16', 'Contact object (16)', 3, '', 12, 1),
(85, '2024-01-28 20:24:22.096008+00', '15', 'Contact object (15)', 3, '', 12, 1),
(86, '2024-01-28 20:24:22.294488+00', '14', 'Contact object (14)', 3, '', 12, 1),
(87, '2024-01-28 20:24:22.497339+00', '13', 'Contact object (13)', 3, '', 12, 1),
(88, '2024-01-28 20:24:22.69602+00', '12', 'Contact object (12)', 3, '', 12, 1),
(89, '2024-01-28 20:24:22.895123+00', '11', 'Contact object (11)', 3, '', 12, 1),
(90, '2024-01-28 20:24:23.093051+00', '10', 'Contact object (10)', 3, '', 12, 1),
(91, '2024-01-28 20:24:23.294097+00', '9', 'Contact object (9)', 3, '', 12, 1),
(92, '2024-01-28 20:24:23.492353+00', '8', 'Contact object (8)', 3, '', 12, 1),
(93, '2024-01-28 20:24:23.691471+00', '7', 'Contact object (7)', 3, '', 12, 1),
(94, '2024-01-28 20:24:23.892152+00', '6', 'Contact object (6)', 3, '', 12, 1),
(95, '2024-01-28 20:24:24.092109+00', '5', 'Contact object (5)', 3, '', 12, 1),
(96, '2024-01-28 20:24:24.292306+00', '4', 'Contact object (4)', 3, '', 12, 1),
(97, '2024-01-28 20:24:24.492141+00', '3', 'Contact object (3)', 3, '', 12, 1),
(98, '2024-01-28 20:24:24.690183+00', '2', 'Contact object (2)', 3, '', 12, 1),
(99, '2024-01-28 20:24:24.889109+00', '1', 'Contact object (1)', 3, '', 12, 1),
(100, '2024-01-28 20:29:27.417803+00', '9', 'Tic Tac Toe', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(101, '2024-01-28 20:30:36.809573+00', '8', 'Python ChatGPT Gui', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(102, '2024-01-28 20:31:17.941347+00', '7', 'Python Student Management System', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(103, '2024-01-28 20:32:09.916868+00', '6', 'Invoice Manager WebApp', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(104, '2024-01-28 20:33:15.978821+00', '5', 'Guess The Number', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(105, '2024-01-28 20:33:50.15767+00', '4', 'Shoot The Crow', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(106, '2024-01-28 20:34:42.052019+00', '3', 'The Pig Game', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(107, '2024-01-28 20:35:25.608322+00', '1', 'Django and Vue WebStore', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(108, '2024-01-28 20:36:49.3122+00', '1', 'Django and Vue WebStore', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(109, '2024-01-28 20:37:26.424354+00', '1', 'Django and Vue WebStore', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(110, '2024-01-28 20:38:03.381793+00', '1', 'Django and Vue WebStore', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1),
(111, '2024-01-28 20:38:28.275288+00', '1', 'Django and Vue WebStore', 2, '[{"changed": {"fields": ["Description"]}}]', 7, 1);

INSERT INTO "public"."django_content_type" ("id", "app_label", "model") VALUES
(1, 'admin', 'logentry');
INSERT INTO "public"."django_content_type" ("id", "app_label", "model") VALUES
(2, 'auth', 'permission');
INSERT INTO "public"."django_content_type" ("id", "app_label", "model") VALUES
(3, 'auth', 'group');
INSERT INTO "public"."django_content_type" ("id", "app_label", "model") VALUES
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'portofolio', 'projects'),
(8, 'portofolio', 'skills'),
(9, 'portofolio', 'profile'),
(10, 'authtoken', 'token'),
(11, 'authtoken', 'tokenproxy'),
(12, 'portofolio', 'contact');

INSERT INTO "public"."django_migrations" ("id", "app", "name", "applied") VALUES
(1, 'contenttypes', '0001_initial', '2023-11-30 20:46:52.957737+00');
INSERT INTO "public"."django_migrations" ("id", "app", "name", "applied") VALUES
(2, 'auth', '0001_initial', '2023-11-30 20:46:58.938876+00');
INSERT INTO "public"."django_migrations" ("id", "app", "name", "applied") VALUES
(3, 'admin', '0001_initial', '2023-11-30 20:47:00.696913+00');
INSERT INTO "public"."django_migrations" ("id", "app", "name", "applied") VALUES
(4, 'admin', '0002_logentry_remove_auto_add', '2023-11-30 20:47:01.272735+00'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2023-11-30 20:47:02.040899+00'),
(6, 'contenttypes', '0002_remove_content_type_name', '2023-11-30 20:47:03.191896+00'),
(7, 'auth', '0002_alter_permission_name_max_length', '2023-11-30 20:47:04.146839+00'),
(8, 'auth', '0003_alter_user_email_max_length', '2023-11-30 20:47:05.10146+00'),
(9, 'auth', '0004_alter_user_username_opts', '2023-11-30 20:47:05.867992+00'),
(10, 'auth', '0005_alter_user_last_login_null', '2023-11-30 20:47:06.823467+00'),
(11, 'auth', '0006_require_contenttypes_0002', '2023-11-30 20:47:07.584657+00'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2023-11-30 20:47:08.350331+00'),
(13, 'auth', '0008_alter_user_username_max_length', '2023-11-30 20:47:09.318043+00'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2023-11-30 20:47:10.272784+00'),
(15, 'auth', '0010_alter_group_name_max_length', '2023-11-30 20:47:11.228256+00'),
(16, 'auth', '0011_update_proxy_permissions', '2023-11-30 20:47:11.994036+00'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2023-11-30 20:47:12.948253+00'),
(18, 'portofolio', '0001_initial', '2023-11-30 20:47:15.077793+00'),
(19, 'sessions', '0001_initial', '2023-11-30 20:47:16.431799+00'),
(20, 'authtoken', '0001_initial', '2023-12-08 13:36:19.319422+00'),
(21, 'authtoken', '0002_auto_20160226_1747', '2023-12-08 13:36:19.927572+00'),
(22, 'authtoken', '0003_tokenproxy', '2023-12-08 13:36:20.709506+00'),
(23, 'portofolio', '0002_rename_bio_profile_primary_bio_profile_secondary_bio', '2023-12-08 13:36:21.887999+00'),
(24, 'portofolio', '0003_contact', '2023-12-10 16:39:37.033401+00'),
(25, 'portofolio', '0004_delete_skills_rename_title_projects_mame_and_more', '2023-12-12 19:45:22.472554+00'),
(26, 'portofolio', '0005_rename_mame_projects_name', '2023-12-12 19:48:34.652637+00'),
(27, 'portofolio', '0006_alter_projects_description', '2023-12-12 19:57:18.605941+00'),
(28, 'portofolio', '0007_projects_category', '2023-12-20 00:32:21.500064+00'),
(29, 'portofolio', '0008_alter_projects_category', '2023-12-20 00:35:51.792274+00'),
(30, 'portofolio', '0009_rename_host_link_projects_hostlink_and_more', '2023-12-20 00:48:33.340497+00'),
(31, 'portofolio', '0010_alter_projects_options_alter_contact_message_and_more', '2024-01-27 22:08:11.433493+00');

INSERT INTO "public"."django_session" ("session_key", "session_data", "expire_date") VALUES
('x3zw5hm7uencaq3i2cu36c8gh38hwafw', '.eJxVjEEOwiAQRe_C2hAGsAMu3XsGMsAgVUOT0q6Md7dNutDte-__twi0LjWsnecwZnERIE6_LFJ6cttFflC7TzJNbZnHKPdEHrbL25T5dT3av4NKvW5r61RB5uK1d2oA8AiIDGwSRYiAeih5gwaZzslmqzUXpyya6Ix2nsXnC8oZNyk:1r8oWr:RGfc7avBXvaNaK2Hw-igB2_owN9sAYkUJifmmjlLLGs', '2023-12-14 21:25:01.46615+00');
INSERT INTO "public"."django_session" ("session_key", "session_data", "expire_date") VALUES
('xc6p8oasaz3qzbckghze4b90g07b4uwt', '.eJxVjEEOwiAQRe_C2hAGsAMu3XsGMsAgVUOT0q6Md7dNutDte-__twi0LjWsnecwZnERIE6_LFJ6cttFflC7TzJNbZnHKPdEHrbL25T5dT3av4NKvW5r61RB5uK1d2oA8AiIDGwSRYiAeih5gwaZzslmqzUXpyya6Ix2nsXnC8oZNyk:1rBdl8:dPUZ16sL8LcppaGgkwmVR5rTpdbHl9Pqiy8NzMYBzvE', '2023-12-22 16:31:26.843864+00');
INSERT INTO "public"."django_session" ("session_key", "session_data", "expire_date") VALUES
('b0ig201thsqtjw7gnh0ord3kpwsjlwxg', '.eJxVjEEOwiAQRe_C2hAGsAMu3XsGMsAgVUOT0q6Md7dNutDte-__twi0LjWsnecwZnERIE6_LFJ6cttFflC7TzJNbZnHKPdEHrbL25T5dT3av4NKvW5r61RB5uK1d2oA8AiIDGwSRYiAeih5gwaZzslmqzUXpyya6Ix2nsXnC8oZNyk:1rD8Rx:q14QizgIyCV72kTd3o_DXeHIYOcuKpZ6cHurjtPgKiA', '2023-12-26 19:29:49.611817+00');
INSERT INTO "public"."django_session" ("session_key", "session_data", "expire_date") VALUES
('rp0qgpvfp23bew6hz1bngeeiepjzo3uo', '.eJxVjEEOwiAQRe_C2hAGsAMu3XsGMsAgVUOT0q6Md7dNutDte-__twi0LjWsnecwZnERIE6_LFJ6cttFflC7TzJNbZnHKPdEHrbL25T5dT3av4NKvW5r61RB5uK1d2oA8AiIDGwSRYiAeih5gwaZzslmqzUXpyya6Ix2nsXnC8oZNyk:1rFkW5:eEfmlBL4a8BDfdzZunsqK28uh12wGxojBGpRM_QB2ec', '2024-01-03 00:32:53.9566+00'),
('zjn718ylib3px5py8hmjgf7grk7nlmou', '.eJxVjEEOwiAQRe_C2hAGsAMu3XsGMsAgVUOT0q6Md7dNutDte-__twi0LjWsnecwZnERIE6_LFJ6cttFflC7TzJNbZnHKPdEHrbL25T5dT3av4NKvW5r61RB5uK1d2oA8AiIDGwSRYiAeih5gwaZzslmqzUXpyya6Ix2nsXnC8oZNyk:1rT7HR:thBNAhTDcs76fBBopMQO67gUPn7UOe2qvdz9kc5SJgM', '2024-02-08 21:29:01.999179+00');



INSERT INTO "public"."portofolio_profile" ("id", "primary_bio", "has_bio", "user_id", "secondary_bio") VALUES
(1, '<h2>Hello! I&#39;m Costin Bogdan, a 21-year-old developer with a year of experience in Python. I&#39;m well-versed in web development, covering HTML, CSS, PostgreSQL, Vue, and Django.</h2>', 't', 1, '<h4>My skills span both front-end and back-end technologies, reflecting a comprehensive understanding of the development landscape. Excited about the journey ahead, I&#39;m eager to continue expanding my expertise and exploring new opportunities in the ever-evolving world of programming.</h4>');


INSERT INTO "public"."portofolio_projects" ("id", "name", "slug", "github", "hostLink", "isHosted", "isActive", "date_added", "date_modified", "description", "category") VALUES
(8, 'Python ChatGPT Gui', 'chat', 'https://github.com/ZxPower145/python-chatgpt-chatbot', NULL, 'f', 't', '2023-12-12 19:39:06.452993+00', '2024-01-28 20:30:36.613208+00', '<p>Explore an enhanced user experience with a sleek and intuitive ChatBot Graphical User Interface (GUI) designed to seamlessly interact with the powerful capabilities of the ChatGPT API. This interface not only simplifies communication but also offers a visually appealing and user-friendly platform for harnessing the potential of ChatGPT&#39;s advanced language processing. Engage in dynamic conversations and unlock the full potential of the ChatGPT API through this thoughtfully crafted GUI</p>', 'APP');
INSERT INTO "public"."portofolio_projects" ("id", "name", "slug", "github", "hostLink", "isHosted", "isActive", "date_added", "date_modified", "description", "category") VALUES
(7, 'Python Student Management System', 'student', 'https://github.com/ZxPower145/student-management-system-guy', NULL, 'f', 't', '2023-12-12 19:38:34.295418+00', '2024-01-28 20:31:17.736743+00', '<p>Key App Features:</p>

<p>- Effortlessly manage student information with the ability to add, edit, or delete entries, including Name, Course, and Mobile details.</p>

<p>- Streamline your workflow by easily searching for a specific student using their name, ensuring quick access to relevant information.</p>', 'APP');
INSERT INTO "public"."portofolio_projects" ("id", "name", "slug", "github", "hostLink", "isHosted", "isActive", "date_added", "date_modified", "description", "category") VALUES
(6, 'Invoice Manager WebApp', 'invoice', 'https://github.com/ZxPower145/python-invoice-manager-webapp', NULL, 'f', 't', '2023-12-12 19:37:53.205383+00', '2024-01-28 20:32:09.713157+00', '<p>Introducing a user-friendly web application that simplifies invoice management:</p>

<p>-&nbsp;Seamlessly add, view, edit, or delete invoices with ease.</p>

<p>-&nbsp;Enjoy the convenience of automated calculations for Invoice ID, date, item total, and overall invoice total, enhancing accuracy and efficiency in your invoicing process.</p>', 'WEBSITE');
INSERT INTO "public"."portofolio_projects" ("id", "name", "slug", "github", "hostLink", "isHosted", "isActive", "date_added", "date_modified", "description", "category") VALUES
(5, 'Guess The Number', 'guess', 'https://github.com/ZxPower145/guess-the-number', NULL, 'f', 't', '2023-12-12 19:34:39.279027+00', '2024-01-28 20:33:15.781051+00', '<p>Engage in an exciting guessing game with the following rules:</p>

<p>-&nbsp;A random number between 0 and 20 is generated and kept hidden.</p>

<p>-&nbsp;Your task is to input a number and make an informed guess.</p>

<p>-&nbsp;The game provides feedback, indicating whether your guess is correct, higher, or lower than the hidden number.</p>

<p>-&nbsp;You have a total of 10 attempts to decipher the mystery and make the right guess.</p>

<p>Good luck!</p>', 'GAME'),
(4, 'Shoot The Crow', 'shoot', 'https://github.com/ZxPower145/shoot-the-crow', NULL, 'f', 't', '2023-12-12 19:33:36.511205+00', '2024-01-28 20:33:49.95714+00', '<p>- Test your aiming skills by clicking on a crow to take your shot! Immerse yourself in this JavaScript game, where precision and timing are key as you aim to hit your target using dynamic sprites.</p>', 'GAME'),
(3, 'The Pig Game', 'piggame', 'https://github.com/ZxPower145/pig-game', NULL, 'f', 't', '2023-12-12 19:32:38.435803+00', '2024-01-28 20:34:41.856107+00', '<p>Embark on an exciting two-player dice game with the following rules:</p>

<p>- Players take turns rolling a dice.</p>

<p>- The first player to reach 100 points emerges victorious.</p>

<p>- Beware! If you roll a 1, your current score resets to 0, and it&#39;s the other player&#39;s turn.</p>

<p>- Click &#39;Hold&#39; to secure your current points, preventing them from being lost in case you roll a 1.</p>

<p>Strategy and luck come together in this thrilling quest for victory!</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>', 'GAME'),
(9, 'Tic Tac Toe', 'tictactoe', 'https://github.com/ZxPower145/Tic-Tac-Toe/tree/main', NULL, 'f', 't', '2024-01-27 23:56:12.923319+00', '2024-01-28 20:29:27.216666+00', '<p>Embark on the excitement of a straightforward Tic Tac Toe game with the following features:</p>

<p>- Input for X or O is assigned to the corresponding index within an array.</p>

<p>- The game diligently verifies for a winning scenario by checking if three identical elements align in a row (e.g., X, X, X).</p>

<p>- Additionally, it scrutinizes for victory diagonally, ensuring that three of the same elements form a winning combination.</p>', 'GAME'),
(1, 'Django and Vue WebStore', 'webstore', 'https://github.com/ZxPower145/django-and-vue-webstore/tree/main', 'https://zxwebstore.com', 't', 't', '2023-11-30 21:33:38.458221+00', '2024-01-28 20:38:28.072623+00', '<p>Please note that the payment functionality is currently disabled. The platform employs API calls to the backend for various features, including:</p>

<h4>- Displaying products, either by category or showcasing the last three on the homepage.</h4>

<h4>- Adding products to the shopping cart.</h4>

<h4>- Placing orders and facilitating payment through Stripe.</h4>

<h4>- Managing user accounts, which includes functionalities such as login, registration, and user profile editing (name, email, password, etc.).</h4>

<h4>- Administering the manipulation of data through Django&#39;s admin interface, including adding, editing, or removing information as needed.</h4>', 'WEBSITE');
