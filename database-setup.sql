-- ===================================================================
-- CAP Event Command System - Database Setup (Updated)
-- ===================================================================
-- Copy and paste this ENTIRE file into Supabase SQL Editor and run it
-- ===================================================================

-- Clean up existing tables (if any)
DROP TABLE IF EXISTS support_tickets CASCADE;
DROP TABLE IF EXISTS logs CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TABLE IF EXISTS roster CASCADE;
DROP TABLE IF EXISTS locations CASCADE;
DROP TABLE IF EXISTS personnel CASCADE;
DROP TABLE IF EXISTS inprocessing_checkins CASCADE;
DROP TABLE IF EXISTS inprocessing_stations CASCADE;
DROP TABLE IF EXISTS assets CASCADE;
DROP TABLE IF EXISTS activities CASCADE;
DROP TABLE IF EXISTS events CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS event_roster CASCADE;
DROP TABLE IF EXISTS event_accommodations CASCADE;
DROP TABLE IF EXISTS event_allergies CASCADE;

-- ===================================================================
-- CREATE TABLES
-- ===================================================================

-- Users table
CREATE TABLE users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    cap_id TEXT UNIQUE NOT NULL,
    role TEXT DEFAULT 'user' CHECK (role IN ('admin', 'staff', 'user')),
    name TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Roles (support roles) table
CREATE TABLE roles (
    name TEXT PRIMARY KEY
);

-- Events table (Master events)
CREATE TABLE events (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    personnel_needed INTEGER DEFAULT 0,
    assets_needed INTEGER DEFAULT 0,
    sandbox_mode BOOLEAN DEFAULT FALSE,
    status TEXT DEFAULT 'upcoming' CHECK (status IN ('upcoming', 'active', 'completed')),
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    assigned_personnel JSONB DEFAULT '[]'::jsonb,
    assigned_assets JSONB DEFAULT '[]'::jsonb
);

-- Locations
CREATE TABLE locations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    street TEXT,
    city TEXT,
    state TEXT,
    zip TEXT,
    lat DOUBLE PRECISION,
    lng DOUBLE PRECISION,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    sandbox_mode BOOLEAN DEFAULT FALSE
);

-- Activities table (Sub-events within master events)
CREATE TABLE activities (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    "column" TEXT DEFAULT 'Planning' CHECK ("column" IN ('Planning', 'Ready', 'In Progress', 'Completed')),
    activity_date DATE,
    start_time TIME,
    end_time TIME,
    location_id UUID REFERENCES locations(id) ON DELETE SET NULL,
    support_personnel_required JSONB DEFAULT '[]'::jsonb,
    assets_required JSONB DEFAULT '[]'::jsonb,
    assigned_personnel JSONB DEFAULT '[]'::jsonb,
    assigned_assets JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    sandbox_mode BOOLEAN DEFAULT FALSE
);

-- Assets table (Vehicles, Equipment, etc.)
CREATE TABLE assets (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    details TEXT,
    asset_id TEXT,
    status TEXT DEFAULT 'available' CHECK (status IN ('available', 'assigned')),
    assigned_to TEXT,
    assigned_personnel JSONB DEFAULT '[]'::jsonb,
    availability JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    sandbox_mode BOOLEAN DEFAULT FALSE
);

-- Personnel table (Team members)
CREATE TABLE personnel (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    cap_id TEXT NOT NULL,
    rank TEXT,
    specialties TEXT,
    status TEXT DEFAULT 'available' CHECK (status IN ('available', 'assigned')),
    assigned_to TEXT,
    availability JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    sandbox_mode BOOLEAN DEFAULT FALSE
);

-- Inprocessing Stations table
CREATE TABLE inprocessing_stations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    station_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Inprocessing Check-ins table
CREATE TABLE inprocessing_checkins (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    station_id UUID REFERENCES inprocessing_stations(id) ON DELETE CASCADE,
    personnel_id TEXT NOT NULL,
    checked_in_at TIMESTAMPTZ DEFAULT NOW(),
    checked_in_by TEXT
);

CREATE INDEX idx_stations_event ON inprocessing_stations(event_id);
CREATE INDEX idx_checkins_station ON inprocessing_checkins(station_id);

-- Event-specific uploads
CREATE TABLE event_roster (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    cap_id TEXT NOT NULL,
    name_first TEXT,
    name_last TEXT,
    full_name TEXT,
    rank TEXT,
    region TEXT,
    wing TEXT,
    unit TEXT,
    gender TEXT,
    dob TEXT,
    age INTEGER,
    shirt_size TEXT,
    member_type TEXT,
    expiration TEXT,
    member_status TEXT,
    home_phone TEXT,
    cell_phone TEXT,
    emergency_contact_name TEXT,
    emergency_contact_phone TEXT,
    email TEXT,
    unit_approved TEXT,
    parent_approved TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE event_accommodations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    cap_id TEXT NOT NULL,
    full_name TEXT,
    member_type TEXT,
    accommodation_type TEXT,
    temporary TEXT,
    start_date TEXT,
    end_date TEXT,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE event_allergies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    cap_id TEXT NOT NULL,
    is_anaphyaxis TEXT,
    has_epipen TEXT,
    has_albuterol_inhaler TEXT,
    full_name TEXT,
    allergy_name TEXT,
    allergy_type TEXT,
    typical_reactions TEXT,
    treatments TEXT,
    contact_name TEXT,
    emergency_contact TEXT,
    commander_name TEXT,
    commander_contact TEXT,
    other_medications TEXT,
    other_reactions TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_roster_event ON event_roster(event_id);
CREATE INDEX idx_roster_capid ON event_roster(cap_id);
CREATE INDEX idx_accommodations_event ON event_accommodations(event_id);
CREATE INDEX idx_accommodations_capid ON event_accommodations(cap_id);
CREATE INDEX idx_allergies_event ON event_allergies(event_id);
CREATE INDEX idx_allergies_capid ON event_allergies(cap_id);


-- Roster (event sign-in/out + inprocessing)
CREATE TABLE roster (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    cap_id TEXT NOT NULL,
    name TEXT,
    firstName TEXT,
    lastName TEXT,
    rank TEXT,
    role TEXT DEFAULT 'student',
    signed_in_at TIMESTAMPTZ,
    signed_out_at TIMESTAMPTZ,
    inprocess_completed_at TIMESTAMPTZ,
    stations JSONB DEFAULT '{}'::jsonb,
    flags JSONB DEFAULT '[]'::jsonb,
    profile JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    sandbox_mode BOOLEAN DEFAULT FALSE
);

-- Logs (notes + audit entries)
CREATE TABLE logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    type TEXT DEFAULT 'note',
    action TEXT,
    entity_type TEXT,
    entity_id TEXT,
    entity_name TEXT,
    details JSONB DEFAULT '{}'::jsonb,
    cap_id TEXT,
    name TEXT,
    rank TEXT,
    actor_cap_id TEXT,
    actor_name TEXT,
    actor_rank TEXT,
    actor_role TEXT,
    message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    sandbox_mode BOOLEAN DEFAULT FALSE
);

-- Support tickets
CREATE TABLE support_tickets (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    subject TEXT NOT NULL,
    details TEXT NOT NULL,
    status TEXT DEFAULT 'open' CHECK (status IN ('open', 'closed')),
    cap_id TEXT,
    name TEXT,
    rank TEXT,
    created_by TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    closed_at TIMESTAMPTZ,
    closed_by TEXT,
    closed_remarks TEXT,
    sandbox_mode BOOLEAN DEFAULT FALSE
);

-- ===================================================================
-- CREATE INDEXES FOR PERFORMANCE
-- ===================================================================

CREATE INDEX idx_events_status ON events(status);
CREATE INDEX idx_events_created_by ON events(created_by);
CREATE INDEX idx_events_date_range ON events(start_date, end_date);

CREATE INDEX idx_activities_event_id ON activities(event_id);
CREATE INDEX idx_activities_column ON activities("column");
CREATE INDEX idx_activities_date ON activities(activity_date);

CREATE INDEX idx_assets_status ON assets(status);
CREATE INDEX idx_assets_type ON assets(type);

CREATE INDEX idx_personnel_status ON personnel(status);
CREATE INDEX idx_personnel_cap_id ON personnel(cap_id);

CREATE INDEX idx_users_cap_id ON users(cap_id);
CREATE INDEX idx_roster_event_id ON roster(event_id);
CREATE INDEX idx_roster_cap_id ON roster(cap_id);
CREATE INDEX idx_logs_type ON logs(type);
CREATE INDEX idx_logs_created_at ON logs(created_at);
CREATE INDEX idx_support_status ON support_tickets(status);

-- ===================================================================
-- ENABLE ROW LEVEL SECURITY (RLS)
-- ===================================================================

ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE assets ENABLE ROW LEVEL SECURITY;
ALTER TABLE personnel ENABLE ROW LEVEL SECURITY;
ALTER TABLE locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE roster ENABLE ROW LEVEL SECURITY;
ALTER TABLE logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE support_tickets ENABLE ROW LEVEL SECURITY;
ALTER TABLE inprocessing_stations ENABLE ROW LEVEL SECURITY;
ALTER TABLE inprocessing_checkins ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_roster ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_accommodations ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_allergies ENABLE ROW LEVEL SECURITY;

-- ===================================================================
-- CREATE SECURITY POLICIES
-- ===================================================================
-- Note: These are permissive policies for simplicity

CREATE POLICY "Allow all operations on users" ON users FOR ALL USING (true);
CREATE POLICY "Allow all operations on roles" ON roles FOR ALL USING (true);
CREATE POLICY "Allow all operations on events" ON events FOR ALL USING (true);
CREATE POLICY "Allow all operations on activities" ON activities FOR ALL USING (true);
CREATE POLICY "Allow all operations on assets" ON assets FOR ALL USING (true);
CREATE POLICY "Allow all operations on personnel" ON personnel FOR ALL USING (true);
CREATE POLICY "Allow all operations on locations" ON locations FOR ALL USING (true);
CREATE POLICY "Allow all operations on roster" ON roster FOR ALL USING (true);
CREATE POLICY "Allow all operations on logs" ON logs FOR ALL USING (true);
CREATE POLICY "Allow all operations on support_tickets" ON support_tickets FOR ALL USING (true);

CREATE POLICY "Allow all on stations" ON inprocessing_stations FOR ALL USING (true);
CREATE POLICY "Allow all on checkins" ON inprocessing_checkins FOR ALL USING (true);
CREATE POLICY "Allow all on roster" ON event_roster FOR ALL USING (true);
CREATE POLICY "Allow all on accommodations" ON event_accommodations FOR ALL USING (true);
CREATE POLICY "Allow all on allergies" ON event_allergies FOR ALL USING (true);

-- ===================================================================
-- INSERT BASE ROLES
-- ===================================================================

INSERT INTO roles (name) VALUES
('Driver'),
('Safety Officer'),
('HSO'),
('Support Staff'),
('Orientation Pilot'),
('TO'),
('Other')
ON CONFLICT DO NOTHING;

-- ===================================================================
-- VERIFICATION QUERIES
-- ===================================================================

SELECT tablename FROM pg_tables WHERE schemaname = 'public' ORDER BY tablename;
SELECT tablename, rowsecurity FROM pg_tables WHERE schemaname = 'public';

SELECT 'users' as table_name, COUNT(*) as record_count FROM users
UNION ALL
SELECT 'roles', COUNT(*) FROM roles
UNION ALL
SELECT 'events', COUNT(*) FROM events
UNION ALL
SELECT 'activities', COUNT(*) FROM activities
UNION ALL
SELECT 'assets', COUNT(*) FROM assets
UNION ALL
SELECT 'personnel', COUNT(*) FROM personnel
UNION ALL
SELECT 'locations', COUNT(*) FROM locations
UNION ALL
SELECT 'roster', COUNT(*) FROM roster
UNION ALL
SELECT 'logs', COUNT(*) FROM logs
UNION ALL
SELECT 'support_tickets', COUNT(*) FROM support_tickets;

-- ===================================================================
-- SETUP COMPLETE!
-- ===================================================================
