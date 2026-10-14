PRAGMA defer_foreign_keys=TRUE;
CREATE TABLE d1_migrations(
		id         INTEGER PRIMARY KEY AUTOINCREMENT,
		name       TEXT UNIQUE,
		applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(1,'0001_init.sql','2026-10-06 16:28:45');
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(2,'0002_advanced_settings.sql','2026-10-06 17:45:06');
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(3,'0003_media_video_features.sql','2026-10-07 00:51:05');
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(4,'0004_culture_topics.sql','2026-10-11 04:06:07');
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(5,'0005_platform_core.sql','2026-10-11 04:06:08');
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(6,'0006_seed_taxonomy.sql','2026-10-11 04:06:08');
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(7,'0007_original_media_only.sql','2026-10-11 04:06:08');
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(8,'0008_default_hero_video.sql','2026-10-11 04:06:08');
CREATE TABLE admins (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  salt TEXT NOT NULL,
  display_name TEXT NOT NULL DEFAULT 'Amit Kumar Tharu',
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
, role TEXT NOT NULL DEFAULT 'admin', active INTEGER NOT NULL DEFAULT 1, password_algo TEXT NOT NULL DEFAULT 'legacy', last_login_at TEXT NOT NULL DEFAULT '');
INSERT INTO "admins" ("id","username","password_hash","salt","display_name","created_at","updated_at","role","active","password_algo","last_login_at") VALUES(1,'Admin','pbkdf2v1$100000$bNkh69EGEmNWFlWDze6DCg$ZDRh6LdneOAxY2EFoNv6TCagUC1ByN3LGN3k9pnqL2k','-','Amit Kumar Tharu','2026-10-06 16:32:52','2026-10-11T04:13:10.113Z','admin',1,'pbkdf2v1','2026-10-11T07:46:52.900Z');
CREATE TABLE sessions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  token_hash TEXT NOT NULL UNIQUE,
  admin_id INTEGER NOT NULL,
  expires_at INTEGER NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, csrf_token TEXT NOT NULL DEFAULT '', user_agent TEXT NOT NULL DEFAULT '', last_seen_at TEXT NOT NULL DEFAULT '',
  FOREIGN KEY(admin_id) REFERENCES admins(id) ON DELETE CASCADE
);
INSERT INTO "sessions" ("id","token_hash","admin_id","expires_at","created_at","csrf_token","user_agent","last_seen_at") VALUES(1,'km4_ciaVYSbZ6FNbU-LQ9z5B6TuqBVD2cm8g5EErmSE',1,1791735190,'2026-10-11 04:13:10','J9PwTjXYRYoMFfZos0Tgrt279eGNGh09','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36','2026-10-11T04:14:36.788Z');
INSERT INTO "sessions" ("id","token_hash","admin_id","expires_at","created_at","csrf_token","user_agent","last_seen_at") VALUES(2,'KsL0vrjoLF1mzxNcMMWK5Ct9Vg1LBD5HoiFCKMHSv24',1,1791737782,'2026-10-11 04:56:22','pIr5r_a_QU_xCjvJt41tG2a8fZacHc0S','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36','2026-10-11T04:58:44.854Z');
INSERT INTO "sessions" ("id","token_hash","admin_id","expires_at","created_at","csrf_token","user_agent","last_seen_at") VALUES(3,'t7GAAaI95DaEmZoftDBw-LpHY7Ilk231fa8I-tYjiDM',1,1791748013,'2026-10-11 07:46:53','a1lTLFcRSmvjrqTQjaRBEHeytQ4is1Z2','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36','2026-10-11T07:56:57.127Z');
CREATE TABLE login_attempts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ip_hash TEXT NOT NULL,
  attempted_at INTEGER NOT NULL,
  success INTEGER NOT NULL DEFAULT 0
);
INSERT INTO "login_attempts" ("id","ip_hash","attempted_at","success") VALUES(1,'qgPOtOA7vbrIRtx38JHdtI',1791691794,0);
INSERT INTO "login_attempts" ("id","ip_hash","attempted_at","success") VALUES(2,'iUWhK5QfdenLazaE75VOwv0iS36j3vtFKgwKFGjcyKM',1791691794,0);
INSERT INTO "login_attempts" ("id","ip_hash","attempted_at","success") VALUES(3,'qgPOtOA7vbrIRtx38JHdtI',1791691974,0);
INSERT INTO "login_attempts" ("id","ip_hash","attempted_at","success") VALUES(4,'iUWhK5QfdenLazaE75VOwv0iS36j3vtFKgwKFGjcyKM',1791691974,0);
INSERT INTO "login_attempts" ("id","ip_hash","attempted_at","success") VALUES(5,'qgPOtOA7vbrIRtx38JHdtI',1791691990,1);
INSERT INTO "login_attempts" ("id","ip_hash","attempted_at","success") VALUES(6,'MyAuluRb_lMIOSCakybilS',1791694582,1);
INSERT INTO "login_attempts" ("id","ip_hash","attempted_at","success") VALUES(7,'jSZJZaS1HIoELClk4DXMZY',1791704812,1);
CREATE TABLE media (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT DEFAULT '',
  type TEXT NOT NULL CHECK(type IN ('photo','video')),
  category TEXT NOT NULL DEFAULT 'Culture',
  object_key TEXT NOT NULL UNIQUE,
  mime_type TEXT DEFAULT '',
  size INTEGER DEFAULT 0,
  featured INTEGER NOT NULL DEFAULT 0,
  published INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
, credit TEXT NOT NULL DEFAULT '', cultural_context TEXT NOT NULL DEFAULT '', alt_text TEXT NOT NULL DEFAULT '', taken_on TEXT NOT NULL DEFAULT '', archived INTEGER NOT NULL DEFAULT 0, thumb_key TEXT NOT NULL DEFAULT '', captions_key TEXT NOT NULL DEFAULT '', transcript TEXT NOT NULL DEFAULT '', language TEXT NOT NULL DEFAULT 'en', source TEXT NOT NULL DEFAULT 'admin', consent_note TEXT NOT NULL DEFAULT '');
INSERT INTO "media" ("id","title","description","type","category","object_key","mime_type","size","featured","published","created_at","updated_at","credit","cultural_context","alt_text","taken_on","archived","thumb_key","captions_key","transcript","language","source","consent_note") VALUES(1,'tharu','added','photo','Culture','media/5479380b-1c68-4a34-af1d-381b7308d50f-10473003092024gQluSk.jpg','image/jpeg',105038,0,1,'2026-10-06T18:45:23.134Z','2026-10-06T18:45:23.134Z','','','','',0,'','','','en','admin','');
INSERT INTO "media" ("id","title","description","type","category","object_key","mime_type","size","featured","published","created_at","updated_at","credit","cultural_context","alt_text","taken_on","archived","thumb_key","captions_key","transcript","language","source","consent_note") VALUES(2,'10473003092024gQluSk','tharu','photo','Culture','media/34103c19-2f0d-4696-a6bb-3e697147e58a-10473003092024gQluSk.jpg','image/jpeg',105038,0,1,'2026-10-06T19:01:40.017Z','2026-10-06T19:01:40.017Z','','','','',0,'','','','en','admin','');
INSERT INTO "media" ("id","title","description","type","category","object_key","mime_type","size","featured","published","created_at","updated_at","credit","cultural_context","alt_text","taken_on","archived","thumb_key","captions_key","transcript","language","source","consent_note") VALUES(3,'10473003092024gQluSk','tharu','photo','Culture','media/208a7c30-d47d-4696-a71c-f9b351b4e1a0-10473003092024gQluSk.jpg','image/jpeg',105038,0,1,'2026-10-06T19:04:20.484Z','2026-10-06T19:04:20.484Z','','','','',0,'','','','en','admin','');
INSERT INTO "media" ("id","title","description","type","category","object_key","mime_type","size","featured","published","created_at","updated_at","credit","cultural_context","alt_text","taken_on","archived","thumb_key","captions_key","transcript","language","source","consent_note") VALUES(4,'10473003092024gQluSk','tharu','photo','Culture','media/35ba5920-ddc2-4c03-a778-052f1b14a593-10473003092024gQluSk.jpg','image/jpeg',105038,0,1,'2026-10-06T19:04:25.440Z','2026-10-06T19:04:25.440Z','','','','',0,'','','','en','admin','');
INSERT INTO "media" ("id","title","description","type","category","object_key","mime_type","size","featured","published","created_at","updated_at","credit","cultural_context","alt_text","taken_on","archived","thumb_key","captions_key","transcript","language","source","consent_note") VALUES(6,'Tharu','','photo','Culture','media/2951de88-dc07-4962-aa94-521a9e7299bc-102514.webp','image/webp',387196,0,1,'2026-10-11T04:59:00.978Z','2026-10-11T04:59:00.978Z','','','','',0,'thumbs/f46a981d-1a3a-48f4-830e-0f228c5bc056-102514.jpg','','','en','admin','');
CREATE TABLE stories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  category TEXT NOT NULL DEFAULT 'Heritage',
  excerpt TEXT DEFAULT '',
  body TEXT NOT NULL,
  published INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  event_date TEXT NOT NULL,
  venue TEXT DEFAULT '',
  description TEXT DEFAULT '',
  image_media_id INTEGER,
  published INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, timezone TEXT NOT NULL DEFAULT 'Asia/Kathmandu', local_start TEXT NOT NULL DEFAULT '', local_end TEXT NOT NULL DEFAULT '', starts_at TEXT NOT NULL DEFAULT '', ends_at TEXT NOT NULL DEFAULT '', map_url TEXT NOT NULL DEFAULT '', registration_url TEXT NOT NULL DEFAULT '', category TEXT NOT NULL DEFAULT '', organizer TEXT NOT NULL DEFAULT '', status TEXT NOT NULL DEFAULT 'scheduled', cancel_note TEXT NOT NULL DEFAULT '', tags TEXT NOT NULL DEFAULT '',
  FOREIGN KEY(image_media_id) REFERENCES media(id) ON DELETE SET NULL
);
CREATE TABLE settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL DEFAULT '',
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "settings" ("key","value","updated_at") VALUES('site_name','','2026-10-06 19:18:12');
INSERT INTO "settings" ("key","value","updated_at") VALUES('admin_name','Amit Kumar Tharu','2026-10-06 16:32:52');
INSERT INTO "settings" ("key","value","updated_at") VALUES('contact_email','hello@example.com','2026-10-06 16:32:52');
INSERT INTO "settings" ("key","value","updated_at") VALUES('facebook_url','','2026-10-06 19:18:14');
INSERT INTO "settings" ("key","value","updated_at") VALUES('youtube_url','','2026-10-06 19:18:14');
INSERT INTO "settings" ("key","value","updated_at") VALUES('tagline','','2026-10-06 19:18:12');
INSERT INTO "settings" ("key","value","updated_at") VALUES('logo_url','','2026-10-06 19:18:12');
INSERT INTO "settings" ("key","value","updated_at") VALUES('hero_eyebrow','','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('culture_eyebrow','','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('culture_title','','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('culture_lead','','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('gallery_eyebrow','','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('gallery_title','','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('gallery_lead','','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('about_eyebrow','hello','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('about_title','asdjfdgasdff','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('video_eyebrow','tharu mandra nach','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('video_title','watcht full video','2026-10-06 19:18:14');
INSERT INTO "settings" ("key","value","updated_at") VALUES('video_lead','tharu nach','2026-10-06 19:18:14');
INSERT INTO "settings" ("key","value","updated_at") VALUES('footer_note','','2026-10-06 19:18:14');
INSERT INTO "settings" ("key","value","updated_at") VALUES('hero_title','','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('hero_lead','','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('about','dffegh','2026-10-06 19:18:13');
INSERT INTO "settings" ("key","value","updated_at") VALUES('facebook_video_url','my-video.mp4','2026-10-06 19:18:14');
INSERT INTO "settings" ("key","value","updated_at") VALUES('instagram_url','','2026-10-06 19:18:14');
INSERT INTO "settings" ("key","value","updated_at") VALUES('contact_phone','','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('contact_address','','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('hero_media_url','https://www.youtube.com/watch?v=AEDgPANwFRs','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('hero_media_type','youtube','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('hero_media_alt','','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('enabled_languages','en,ne','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('hidden_nav','','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('comments_mode','pre','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('privacy_text','','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('terms_text','','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('contribution_guidelines','','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('hero_poster_url','','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('hero_layout','cover','2026-10-11 04:06:08');
INSERT INTO "settings" ("key","value","updated_at") VALUES('hero_show_logo','1','2026-10-11 04:06:08');
CREATE TABLE activity_logs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  admin_id INTEGER,
  action TEXT NOT NULL,
  target_type TEXT DEFAULT '',
  target_id INTEGER,
  details TEXT DEFAULT '',
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, actor TEXT NOT NULL DEFAULT '',
  FOREIGN KEY(admin_id) REFERENCES admins(id) ON DELETE SET NULL
);
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(1,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:18.753Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(2,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:19.967Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(3,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:20.193Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(4,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:48.839Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(5,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:48.857Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(6,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:49.395Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(7,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:49.540Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(8,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:49.685Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(9,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:49.887Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(10,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:50.161Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(11,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:37:19.716Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(12,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:37:21.047Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(13,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:41:37.613Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(14,NULL,'admin_action','media',1,'Uploaded photo: tharu','2026-10-06T18:45:23.211Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(15,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:45:38.070Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(16,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:24.259Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(17,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:33.220Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(18,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:33.445Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(19,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:33.643Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(20,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:34.634Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(21,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:34.816Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(22,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:34.990Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(23,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:35.148Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(24,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:48:39.545Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(25,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:48:49.549Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(26,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:48:49.722Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(27,NULL,'Uploaded ChatGPT Image Oct 6, 2026, 10_04_56 PM','system',NULL,'Media ID: 5','2026-10-06T19:11:57.203Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(28,NULL,'Updated website settings','system',NULL,'','2026-10-06T19:15:36.468Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(29,NULL,'Updated website settings','system',NULL,'','2026-10-06T19:17:52.078Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(30,NULL,'Updated website settings','system',NULL,'','2026-10-06T19:18:14.475Z','');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(31,1,'Signed in','session',NULL,'','2026-10-11T04:13:10.548Z','Admin');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(32,1,'Signed in','session',NULL,'','2026-10-11T04:56:22.454Z','Admin');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(33,1,'Deleted media: ChatGPT Image Oct 6, 2026, 10_04_56 PM','media',5,'','2026-10-11T04:58:45.461Z','Admin');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(34,1,'Uploaded photo: Tharu','media',6,'','2026-10-11T04:59:01.185Z','Admin');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at","actor") VALUES(35,1,'Signed in','session',NULL,'','2026-10-11T07:46:53.108Z','Admin');
CREATE TABLE media_metadata (
  media_id INTEGER PRIMARY KEY,
  tags TEXT NOT NULL DEFAULT '',
  thumbnail_url TEXT NOT NULL DEFAULT '',
  FOREIGN KEY(media_id) REFERENCES media(id) ON DELETE CASCADE
);
INSERT INTO "media_metadata" ("media_id","tags","thumbnail_url") VALUES(6,'','');
CREATE TABLE media_views (
  media_id INTEGER PRIMARY KEY,
  view_count INTEGER NOT NULL DEFAULT 0,
  updated_at TEXT NOT NULL,
  FOREIGN KEY(media_id) REFERENCES media(id) ON DELETE CASCADE
);
INSERT INTO "media_views" ("media_id","view_count","updated_at") VALUES(1,2,'2026-10-07T05:20:53.773Z');
CREATE TABLE media_comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  media_id INTEGER NOT NULL,
  author_name TEXT NOT NULL,
  body TEXT NOT NULL,
  published INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL,
  FOREIGN KEY(media_id) REFERENCES media(id) ON DELETE CASCADE
);
CREATE TABLE video_links (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  category TEXT NOT NULL DEFAULT 'Culture',
  url TEXT NOT NULL,
  thumbnail_url TEXT NOT NULL DEFAULT '',
  tags TEXT NOT NULL DEFAULT '',
  featured INTEGER NOT NULL DEFAULT 0,
  published INTEGER NOT NULL DEFAULT 1,
  view_count INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
, provider TEXT NOT NULL DEFAULT '', embed_url TEXT NOT NULL DEFAULT '', credit TEXT NOT NULL DEFAULT '', transcript TEXT NOT NULL DEFAULT '', archived INTEGER NOT NULL DEFAULT 0, language TEXT NOT NULL DEFAULT 'en');
CREATE TABLE video_link_comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  video_id INTEGER NOT NULL,
  author_name TEXT NOT NULL,
  body TEXT NOT NULL,
  published INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL,
  FOREIGN KEY(video_id) REFERENCES video_links(id) ON DELETE CASCADE
);
CREATE TABLE culture_topics (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT NOT NULL UNIQUE,
  title TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  about TEXT NOT NULL DEFAULT '',
  image TEXT NOT NULL DEFAULT '',
  published INTEGER NOT NULL DEFAULT 1,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(1,'history-origins','History & Origins','Articles, oral histories and references about Tharu history and origins, contributed and reviewed by the community.','This section collects community-reviewed writing about Tharu history. Each article lists its sources so readers can see where information comes from.','',1,1,'2026-10-11 04:06:08','2026-10-11 04:06:08');
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(2,'language-literature','Language & Literature','Tharu languages, songs, poems, proverbs and written or spoken literature shared by community members.','Tharu communities speak and write in several varieties. Contributions should name the variety and region they come from.','',1,2,'2026-10-11 04:06:08','2026-10-11 04:06:08');
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(3,'living-traditions','Living Traditions','Living Tharu traditions connect family, community, language, food, seasonal knowledge, rituals and everyday practices across generations.','Traditions remain meaningful when they are practiced, taught and adapted by communities. This section presents Tharu cultural knowledge with respect for local variation and lived experience.','',1,3,'2026-10-11 04:06:08','2026-10-11 04:06:08');
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(4,'art-craft','Art & Craft','Tharu visual culture can be seen in wall art, patterns, textiles, ornaments, objects, architecture and handmade craft.','Art and craft carry identity through symbols, materials, techniques and stories. Community documentation helps preserve both the objects and the knowledge behind them.','',1,4,'2026-10-11 04:06:08','2026-10-11 04:06:08');
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(5,'music-dance','Music & Dance','Music, dance and instruments create shared spaces for celebration, storytelling, memory and community participation.','Tharu performance traditions vary by community and occasion. Recording performances and explaining their context helps future generations understand more than the performance alone.','',1,5,'2026-10-11 04:06:08','2026-10-11 04:06:08');
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(6,'festivals','Festivals & Celebrations','Festivals such as Maghi and Ashtimki bring together family, food, ritual, art, music and community memory.','Festivals are living cultural moments rather than static dates. Their meanings, practices and local expressions can be documented respectfully through community stories and images.','',1,6,'2026-10-11 04:06:08','2026-10-11 04:06:08');
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(7,'clothing-ornaments','Clothing & Ornaments','Traditional clothing, jewellery and ornaments, documented with the names and meanings used by the communities that wear them.','Descriptions here are written or reviewed by community members. Regional differences are noted wherever they matter.','',1,7,'2026-10-11 04:06:08','2026-10-11 04:06:08');
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(8,'food-culinary','Food & Culinary Traditions','Everyday and festival foods, cooking methods and food knowledge shared by community members.','Recipes and food practices differ between households and regions. Contributors are credited and sources are listed.','',1,8,'2026-10-11 04:06:08','2026-10-11 04:06:08');
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(9,'architecture-homes','Architecture & Traditional Homes','Traditional homes, building methods, materials and decoration, documented with photographs and community explanations.','Entries describe the places and communities they come from so that local differences are not lost.','',1,9,'2026-10-11 04:06:08','2026-10-11 04:06:08');
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(10,'agriculture-community-life','Agriculture & Community Life','Farming, seasonal work, fishing, forest knowledge and the shared life of Tharu villages.','Community life is described by the people who live it. Seasonal and regional differences are recorded explicitly.','',1,10,'2026-10-11 04:06:08','2026-10-11 04:06:08');
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(11,'oral-history-storytelling','Oral Histories & Storytelling','Stories, songs and interviews passed down by voice, published only with the storyteller''s consent.','Recordings and transcripts appear here only when the speaker or their family has given permission for publication.','',1,11,'2026-10-11 04:06:08','2026-10-11 04:06:08');
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(12,'traditional-knowledge','Traditional Knowledge & Practices','Traditional ecological, medicinal and practical knowledge, shared only where the knowledge holders have agreed to share it.','Some knowledge is restricted. Articles that include sensitive material must record who authorised its publication.','',1,12,'2026-10-11 04:06:08','2026-10-11 04:06:08');
INSERT INTO "culture_topics" ("id","slug","title","description","about","image","published","sort_order","created_at","updated_at") VALUES(13,'regional-variations','Regional Variations & Local Heritage','How Tharu cultural life differs between districts, villages and sub-groups, with local heritage places and stories.','No single description fits every Tharu community. This section exists to make regional differences visible.','',1,13,'2026-10-11 04:06:08','2026-10-11 04:06:08');
CREATE TABLE rate_limits (
  key TEXT PRIMARY KEY,
  count INTEGER NOT NULL DEFAULT 0,
  window_start INTEGER NOT NULL
);
INSERT INTO "rate_limits" ("key","count","window_start") VALUES('track:yWf0S-E20qKqnPFgHe7L8P:1791691200',1,1791691200);
INSERT INTO "rate_limits" ("key","count","window_start") VALUES('track:yoYM9xYHYRo6Q5u_Khmsxb:1791691200',2,1791691200);
INSERT INTO "rate_limits" ("key","count","window_start") VALUES('track:loaZZ70JoliWrLMRiHhGJZ:1791691200',1,1791691200);
INSERT INTO "rate_limits" ("key","count","window_start") VALUES('track:Ub9yDHedKAr0iw9E2Gidba:1791691200',2,1791691200);
INSERT INTO "rate_limits" ("key","count","window_start") VALUES('track:lrNI456GxhDiXqSd79EGFg:1791694800',1,1791694800);
INSERT INTO "rate_limits" ("key","count","window_start") VALUES('track:5MUw8dDNa9XMOU2Nso6T62:1791694800',1,1791694800);
INSERT INTO "rate_limits" ("key","count","window_start") VALUES('track:zgwocCTN8Gyrt4O6O4Ffya:1791694800',4,1791694800);
INSERT INTO "rate_limits" ("key","count","window_start") VALUES('track:i6vGNSQLGyksmM08qB92l8:1791698400',8,1791698400);
INSERT INTO "rate_limits" ("key","count","window_start") VALUES('track:4wfcd6Yl-3UNF0WlFCF0BJ:1791698400',1,1791698400);
INSERT INTO "rate_limits" ("key","count","window_start") VALUES('track:mKcf7_WBKmH4q364sgwZxB:1791698400',2,1791698400);
INSERT INTO "rate_limits" ("key","count","window_start") VALUES('track:4NzlkQTylfNYuw6mdaHjXk:1791702000',11,1791702000);
CREATE TABLE upload_sessions (
  upload_id TEXT PRIMARY KEY,
  object_key TEXT NOT NULL UNIQUE,
  kind TEXT NOT NULL,                 
  mime_type TEXT NOT NULL,
  size INTEGER NOT NULL,
  admin_id INTEGER,
  status TEXT NOT NULL DEFAULT 'open', 
  created_at TEXT NOT NULL
);
CREATE TABLE categories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  scope TEXT NOT NULL,                
  slug TEXT NOT NULL,
  name TEXT NOT NULL,
  name_ne TEXT NOT NULL DEFAULT '',
  sort_order INTEGER NOT NULL DEFAULT 0,
  UNIQUE(scope, slug)
);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(1,'gallery','culture','Culture','संस्कृति',1);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(2,'gallery','festivals','Festivals','चाडपर्व',2);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(3,'gallery','art-craft','Art & Craft','कला र शिल्प',3);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(4,'gallery','music-dance','Music & Dance','संगीत र नृत्य',4);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(5,'gallery','food','Food','खानपान',5);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(6,'gallery','clothing','Clothing & Ornaments','पहिरन र गहना',6);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(7,'gallery','homes','Homes & Architecture','घर र वास्तुकला',7);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(8,'gallery','people','People & Community','मानिस र समुदाय',8);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(9,'gallery','places','Places','स्थानहरू',9);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(10,'video','culture','Culture','संस्कृति',1);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(11,'video','festivals','Festivals','चाडपर्व',2);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(12,'video','music-dance','Music & Dance','संगीत र नृत्य',3);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(13,'video','interviews','Interviews','अन्तर्वार्ता',4);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(14,'event','festival','Festival','चाडपर्व',1);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(15,'event','workshop','Workshop','कार्यशाला',2);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(16,'event','gathering','Community gathering','सामुदायिक भेला',3);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(17,'event','exhibition','Exhibition','प्रदर्शनी',4);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(18,'resource','book','Book','पुस्तक',1);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(19,'resource','paper','Research paper','अनुसन्धान पत्र',2);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(20,'resource','report','Report','प्रतिवेदन',3);
INSERT INTO "categories" ("id","scope","slug","name","name_ne","sort_order") VALUES(21,'resource','link','Web resource','वेब स्रोत',4);
CREATE TABLE articles (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT NOT NULL UNIQUE,
  kind TEXT NOT NULL DEFAULT 'article' CHECK(kind IN ('article','story')),
  topic_id INTEGER REFERENCES culture_topics(id) ON DELETE SET NULL,
  title TEXT NOT NULL,
  summary TEXT NOT NULL DEFAULT '',
  body TEXT NOT NULL DEFAULT '',
  cover_media_id INTEGER REFERENCES media(id) ON DELETE SET NULL,
  cover_url TEXT NOT NULL DEFAULT '',
  cover_caption TEXT NOT NULL DEFAULT '',
  language TEXT NOT NULL DEFAULT 'en',
  author_name TEXT NOT NULL DEFAULT '',
  tags TEXT NOT NULL DEFAULT '',
  references_text TEXT NOT NULL DEFAULT '',
  related_ids TEXT NOT NULL DEFAULT '',          
  region TEXT NOT NULL DEFAULT '',
  authorization_note TEXT NOT NULL DEFAULT '',   
  source TEXT NOT NULL DEFAULT 'admin',          
  status TEXT NOT NULL DEFAULT 'draft' CHECK(status IN ('draft','published','archived')),
  published_at TEXT NOT NULL DEFAULT '',
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  created_by INTEGER REFERENCES admins(id) ON DELETE SET NULL
);
CREATE TABLE article_media (
  article_id INTEGER NOT NULL REFERENCES articles(id) ON DELETE CASCADE,
  media_id INTEGER NOT NULL REFERENCES media(id) ON DELETE CASCADE,
  caption TEXT NOT NULL DEFAULT '',
  sort_order INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY(article_id, media_id)
);
CREATE TABLE translations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  entity_type TEXT NOT NULL,          
  entity_id INTEGER NOT NULL,
  lang TEXT NOT NULL,                 
  field TEXT NOT NULL,                
  value TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK(status IN ('pending','approved','rejected')),
  translator TEXT NOT NULL DEFAULT '',
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  UNIQUE(entity_type, entity_id, lang, field)
);
CREATE TABLE comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  target_type TEXT NOT NULL,          
  target_id INTEGER NOT NULL,
  author_name TEXT NOT NULL,
  body TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK(status IN ('pending','approved','rejected','hidden')),
  ip_hash TEXT NOT NULL DEFAULT '',
  created_at TEXT NOT NULL,
  moderated_at TEXT NOT NULL DEFAULT '',
  moderated_by INTEGER REFERENCES admins(id) ON DELETE SET NULL
);
CREATE TABLE reports (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  target_type TEXT NOT NULL,          
  target_id INTEGER NOT NULL,
  reason TEXT NOT NULL,
  details TEXT NOT NULL DEFAULT '',
  status TEXT NOT NULL DEFAULT 'open' CHECK(status IN ('open','resolved','dismissed')),
  ip_hash TEXT NOT NULL DEFAULT '',
  created_at TEXT NOT NULL,
  resolved_at TEXT NOT NULL DEFAULT '',
  resolved_by INTEGER REFERENCES admins(id) ON DELETE SET NULL
);
CREATE TABLE submissions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  kind TEXT NOT NULL CHECK(kind IN ('story','photo','video_link','event','correction','resource','translation')),
  title TEXT NOT NULL,
  body TEXT NOT NULL DEFAULT '',
  payload TEXT NOT NULL DEFAULT '{}', 
  object_key TEXT NOT NULL DEFAULT '',
  mime_type TEXT NOT NULL DEFAULT '',
  contributor_name TEXT NOT NULL,
  contributor_contact TEXT NOT NULL DEFAULT '', 
  consent INTEGER NOT NULL DEFAULT 0,
  rights_confirmed INTEGER NOT NULL DEFAULT 0,
  status TEXT NOT NULL DEFAULT 'pending' CHECK(status IN ('pending','approved','rejected')),
  review_note TEXT NOT NULL DEFAULT '',
  result_type TEXT NOT NULL DEFAULT '',
  result_id INTEGER,
  ip_hash TEXT NOT NULL DEFAULT '',
  created_at TEXT NOT NULL,
  reviewed_at TEXT NOT NULL DEFAULT '',
  reviewed_by INTEGER REFERENCES admins(id) ON DELETE SET NULL
);
CREATE TABLE contact_messages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  contact TEXT NOT NULL DEFAULT '',
  subject TEXT NOT NULL DEFAULT '',
  body TEXT NOT NULL,
  kind TEXT NOT NULL DEFAULT 'general',  
  status TEXT NOT NULL DEFAULT 'new' CHECK(status IN ('new','read','done')),
  ip_hash TEXT NOT NULL DEFAULT '',
  created_at TEXT NOT NULL
);
CREATE TABLE oral_histories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  speaker TEXT NOT NULL DEFAULT '',
  interviewer TEXT NOT NULL DEFAULT '',
  language TEXT NOT NULL DEFAULT 'en',
  recorded_on TEXT NOT NULL DEFAULT '',
  transcript TEXT NOT NULL DEFAULT '',
  translation_text TEXT NOT NULL DEFAULT '',
  audio_key TEXT NOT NULL DEFAULT '',
  audio_mime TEXT NOT NULL DEFAULT '',
  audio_size INTEGER NOT NULL DEFAULT 0,
  photo_media_id INTEGER REFERENCES media(id) ON DELETE SET NULL,
  consent_status TEXT NOT NULL DEFAULT 'none' CHECK(consent_status IN ('none','pending','granted','restricted')),
  consent_note TEXT NOT NULL DEFAULT '',
  contributor TEXT NOT NULL DEFAULT '',
  tags TEXT NOT NULL DEFAULT '',
  status TEXT NOT NULL DEFAULT 'draft' CHECK(status IN ('draft','published','archived')),
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
CREATE TABLE resources (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  kind TEXT NOT NULL DEFAULT 'link',        
  url TEXT NOT NULL DEFAULT '',
  file_key TEXT NOT NULL DEFAULT '',        
  file_size INTEGER NOT NULL DEFAULT 0,
  authors TEXT NOT NULL DEFAULT '',
  year TEXT NOT NULL DEFAULT '',
  language TEXT NOT NULL DEFAULT 'en',
  category TEXT NOT NULL DEFAULT '',
  tags TEXT NOT NULL DEFAULT '',
  status TEXT NOT NULL DEFAULT 'draft' CHECK(status IN ('draft','published','archived')),
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
CREATE TABLE places (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  category TEXT NOT NULL DEFAULT 'heritage',  
  description TEXT NOT NULL DEFAULT '',
  lat REAL,
  lng REAL,
  coord_precision TEXT NOT NULL DEFAULT 'approximate' CHECK(coord_precision IN ('exact','approximate','hidden')),
  article_id INTEGER REFERENCES articles(id) ON DELETE SET NULL,
  status TEXT NOT NULL DEFAULT 'draft' CHECK(status IN ('draft','published','archived')),
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
CREATE TABLE analytics_events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  event TEXT NOT NULL,                
  target_type TEXT NOT NULL,          
  target_id INTEGER NOT NULL DEFAULT 0,
  day TEXT NOT NULL,
  visitor TEXT NOT NULL,
  created_at TEXT NOT NULL,
  UNIQUE(event, target_type, target_id, day, visitor)
);
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(1,'page_view','page',1,'2026-10-11','yWf0S-E20qKqnPFgHe7L8P','2026-10-11T04:10:14.261Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(2,'page_view','page',1,'2026-10-11','yoYM9xYHYRo6Q5u_Khmsxb','2026-10-11T04:43:21.390Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(4,'page_view','page',1,'2026-10-11','loaZZ70JoliWrLMRiHhGJZ','2026-10-11T04:55:46.053Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(5,'page_view','media',6,'2026-10-11','Ub9yDHedKAr0iw9E2Gidba','2026-10-11T04:59:08.772Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(6,'page_view','page',1,'2026-10-11','Ub9yDHedKAr0iw9E2Gidba','2026-10-11T04:59:25.680Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(7,'page_view','page',1,'2026-10-11','lrNI456GxhDiXqSd79EGFg','2026-10-11T05:16:03.593Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(8,'page_view','page',1,'2026-10-11','5MUw8dDNa9XMOU2Nso6T62','2026-10-11T05:56:39.202Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(9,'page_view','page',1,'2026-10-11','zgwocCTN8Gyrt4O6O4Ffya','2026-10-11T05:56:41.550Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(10,'page_view','page',5,'2026-10-11','zgwocCTN8Gyrt4O6O4Ffya','2026-10-11T05:56:48.544Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(11,'page_view','media',6,'2026-10-11','zgwocCTN8Gyrt4O6O4Ffya','2026-10-11T05:56:59.689Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(13,'page_view','page',1,'2026-10-11','i6vGNSQLGyksmM08qB92l8','2026-10-11T06:01:06.860Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(14,'page_view','page',7,'2026-10-11','i6vGNSQLGyksmM08qB92l8','2026-10-11T06:01:12.122Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(15,'page_view','page',8,'2026-10-11','i6vGNSQLGyksmM08qB92l8','2026-10-11T06:01:14.050Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(16,'page_view','page',9,'2026-10-11','i6vGNSQLGyksmM08qB92l8','2026-10-11T06:02:12.496Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(17,'page_view','page',10,'2026-10-11','i6vGNSQLGyksmM08qB92l8','2026-10-11T06:02:14.297Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(18,'page_view','page',11,'2026-10-11','i6vGNSQLGyksmM08qB92l8','2026-10-11T06:02:15.625Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(19,'page_view','page',6,'2026-10-11','i6vGNSQLGyksmM08qB92l8','2026-10-11T06:02:51.980Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(20,'page_view','page',3,'2026-10-11','i6vGNSQLGyksmM08qB92l8','2026-10-11T06:03:16.587Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(21,'page_view','page',1,'2026-10-11','4wfcd6Yl-3UNF0WlFCF0BJ','2026-10-11T06:03:38.606Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(22,'page_view','page',1,'2026-10-11','mKcf7_WBKmH4q364sgwZxB','2026-10-11T06:27:56.587Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(23,'page_view','page',3,'2026-10-11','mKcf7_WBKmH4q364sgwZxB','2026-10-11T06:28:17.680Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(24,'page_view','page',1,'2026-10-11','4NzlkQTylfNYuw6mdaHjXk','2026-10-11T07:20:51.047Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(29,'page_view','page',5,'2026-10-11','4NzlkQTylfNYuw6mdaHjXk','2026-10-11T07:57:16.834Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(30,'page_view','page',7,'2026-10-11','4NzlkQTylfNYuw6mdaHjXk','2026-10-11T07:57:23.139Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(31,'page_view','page',8,'2026-10-11','4NzlkQTylfNYuw6mdaHjXk','2026-10-11T07:57:24.504Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(32,'page_view','page',6,'2026-10-11','4NzlkQTylfNYuw6mdaHjXk','2026-10-11T07:57:27.907Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(33,'page_view','page',9,'2026-10-11','4NzlkQTylfNYuw6mdaHjXk','2026-10-11T07:57:30.710Z');
INSERT INTO "analytics_events" ("id","event","target_type","target_id","day","visitor","created_at") VALUES(34,'page_view','page',12,'2026-10-11','4NzlkQTylfNYuw6mdaHjXk','2026-10-11T07:57:31.740Z');
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('d1_migrations',8);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('admins',1);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('activity_logs',35);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('media',6);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('culture_topics',13);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('categories',21);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('login_attempts',7);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('analytics_events',34);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('sessions',3);
CREATE INDEX idx_sessions_token ON sessions(token_hash);
CREATE INDEX idx_sessions_expiry ON sessions(expires_at);
CREATE INDEX idx_media_published ON media(published, created_at);
CREATE INDEX idx_stories_published ON stories(published, created_at);
CREATE INDEX idx_events_published ON events(published, event_date);
CREATE INDEX idx_activity_created ON activity_logs(created_at);
CREATE INDEX idx_media_comments_media ON media_comments(media_id, published, created_at DESC);
CREATE INDEX idx_video_links_published ON video_links(published, created_at DESC);
CREATE INDEX idx_video_link_comments_video ON video_link_comments(video_id, published, created_at DESC);
CREATE INDEX idx_culture_topics_public ON culture_topics(published, sort_order, id);
CREATE INDEX idx_login_attempts_ip ON login_attempts(ip_hash, attempted_at);
CREATE INDEX idx_media_public ON media(type, published, archived, created_at DESC);
CREATE INDEX idx_media_category ON media(category);
CREATE INDEX idx_articles_public ON articles(status, kind, published_at DESC);
CREATE INDEX idx_articles_topic ON articles(topic_id, status);
CREATE INDEX idx_translations_lookup ON translations(entity_type, entity_id, lang, status);
CREATE INDEX idx_events_start ON events(published, status, starts_at);
CREATE INDEX idx_comments_target ON comments(target_type, target_id, status, created_at DESC);
CREATE INDEX idx_comments_status ON comments(status, created_at DESC);
CREATE INDEX idx_reports_status ON reports(status, created_at DESC);
CREATE INDEX idx_submissions_status ON submissions(status, created_at DESC);
CREATE INDEX idx_oral_public ON oral_histories(status, consent_status, created_at DESC);
CREATE INDEX idx_resources_public ON resources(status, created_at DESC);
CREATE INDEX idx_analytics_target ON analytics_events(target_type, target_id, event);
CREATE INDEX idx_analytics_day ON analytics_events(day, event);
