PRAGMA defer_foreign_keys=TRUE;
CREATE TABLE d1_migrations(
		id         INTEGER PRIMARY KEY AUTOINCREMENT,
		name       TEXT UNIQUE,
		applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(1,'0001_init.sql','2026-10-06 16:28:45');
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(2,'0002_advanced_settings.sql','2026-10-06 17:45:06');
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(3,'0003_media_video_features.sql','2026-10-07 00:51:05');
CREATE TABLE admins (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  salt TEXT NOT NULL,
  display_name TEXT NOT NULL DEFAULT 'Amit Kumar Tharu',
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "admins" ("id","username","password_hash","salt","display_name","created_at","updated_at") VALUES(1,'Admin','CyebCeAF8B2nRCCEZ/0XiWmx3avbu31jclPdUAz2SzA=','BDT7sdxDVn5E1gQKvXnlBg==','Amit Kumar Tharu','2026-10-06 16:32:52','2026-10-06 16:32:52');
CREATE TABLE sessions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  token_hash TEXT NOT NULL UNIQUE,
  admin_id INTEGER NOT NULL,
  expires_at INTEGER NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(admin_id) REFERENCES admins(id) ON DELETE CASCADE
);
CREATE TABLE login_attempts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ip_hash TEXT NOT NULL,
  attempted_at INTEGER NOT NULL,
  success INTEGER NOT NULL DEFAULT 0
);
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
);
INSERT INTO "media" ("id","title","description","type","category","object_key","mime_type","size","featured","published","created_at","updated_at") VALUES(1,'tharu','added','photo','Culture','media/5479380b-1c68-4a34-af1d-381b7308d50f-10473003092024gQluSk.jpg','image/jpeg',105038,0,1,'2026-10-06T18:45:23.134Z','2026-10-06T18:45:23.134Z');
INSERT INTO "media" ("id","title","description","type","category","object_key","mime_type","size","featured","published","created_at","updated_at") VALUES(2,'10473003092024gQluSk','tharu','photo','Culture','media/34103c19-2f0d-4696-a6bb-3e697147e58a-10473003092024gQluSk.jpg','image/jpeg',105038,0,1,'2026-10-06T19:01:40.017Z','2026-10-06T19:01:40.017Z');
INSERT INTO "media" ("id","title","description","type","category","object_key","mime_type","size","featured","published","created_at","updated_at") VALUES(3,'10473003092024gQluSk','tharu','photo','Culture','media/208a7c30-d47d-4696-a71c-f9b351b4e1a0-10473003092024gQluSk.jpg','image/jpeg',105038,0,1,'2026-10-06T19:04:20.484Z','2026-10-06T19:04:20.484Z');
INSERT INTO "media" ("id","title","description","type","category","object_key","mime_type","size","featured","published","created_at","updated_at") VALUES(4,'10473003092024gQluSk','tharu','photo','Culture','media/35ba5920-ddc2-4c03-a778-052f1b14a593-10473003092024gQluSk.jpg','image/jpeg',105038,0,1,'2026-10-06T19:04:25.440Z','2026-10-06T19:04:25.440Z');
INSERT INTO "media" ("id","title","description","type","category","object_key","mime_type","size","featured","published","created_at","updated_at") VALUES(5,'ChatGPT Image Oct 6, 2026, 10_04_56 PM','dff','photo','Culture','media/837443f5-96a5-4e91-bfea-6638cd3c955b-ChatGPT-Image-Oct-6-2026-10_04_56-PM.png','image/png',1344169,0,1,'2026-10-06T19:11:57.020Z','2026-10-06T19:11:57.020Z');
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
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
CREATE TABLE activity_logs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  admin_id INTEGER,
  action TEXT NOT NULL,
  target_type TEXT DEFAULT '',
  target_id INTEGER,
  details TEXT DEFAULT '',
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(admin_id) REFERENCES admins(id) ON DELETE SET NULL
);
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(1,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:18.753Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(2,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:19.967Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(3,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:20.193Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(4,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:48.839Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(5,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:48.857Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(6,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:49.395Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(7,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:49.540Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(8,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:49.685Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(9,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:49.887Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(10,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:29:50.161Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(11,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:37:19.716Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(12,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:37:21.047Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(13,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:41:37.613Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(14,NULL,'admin_action','media',1,'Uploaded photo: tharu','2026-10-06T18:45:23.211Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(15,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:45:38.070Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(16,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:24.259Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(17,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:33.220Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(18,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:33.445Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(19,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:33.643Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(20,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:34.634Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(21,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:34.816Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(22,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:34.990Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(23,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:46:35.148Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(24,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:48:39.545Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(25,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:48:49.549Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(26,NULL,'admin_action','',NULL,'Updated website settings','2026-10-06T18:48:49.722Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(27,NULL,'Uploaded ChatGPT Image Oct 6, 2026, 10_04_56 PM','system',NULL,'Media ID: 5','2026-10-06T19:11:57.203Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(28,NULL,'Updated website settings','system',NULL,'','2026-10-06T19:15:36.468Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(29,NULL,'Updated website settings','system',NULL,'','2026-10-06T19:17:52.078Z');
INSERT INTO "activity_logs" ("id","admin_id","action","target_type","target_id","details","created_at") VALUES(30,NULL,'Updated website settings','system',NULL,'','2026-10-06T19:18:14.475Z');
CREATE TABLE media_metadata (
  media_id INTEGER PRIMARY KEY,
  tags TEXT NOT NULL DEFAULT '',
  thumbnail_url TEXT NOT NULL DEFAULT '',
  FOREIGN KEY(media_id) REFERENCES media(id) ON DELETE CASCADE
);
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
);
CREATE TABLE video_link_comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  video_id INTEGER NOT NULL,
  author_name TEXT NOT NULL,
  body TEXT NOT NULL,
  published INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL,
  FOREIGN KEY(video_id) REFERENCES video_links(id) ON DELETE CASCADE
);
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('d1_migrations',3);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('admins',1);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('activity_logs',30);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('media',5);
CREATE INDEX idx_sessions_token ON sessions(token_hash);
CREATE INDEX idx_sessions_expiry ON sessions(expires_at);
CREATE INDEX idx_media_published ON media(published, created_at);
CREATE INDEX idx_stories_published ON stories(published, created_at);
CREATE INDEX idx_events_published ON events(published, event_date);
CREATE INDEX idx_activity_created ON activity_logs(created_at);
CREATE INDEX idx_media_comments_media ON media_comments(media_id, published, created_at DESC);
CREATE INDEX idx_video_links_published ON video_links(published, created_at DESC);
CREATE INDEX idx_video_link_comments_video ON video_link_comments(video_id, published, created_at DESC);
