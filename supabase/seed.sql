-- ===================================================================
-- CAP Event Command System - Sandbox Seed Data
-- ===================================================================
-- This seed data is SAFE to re-run (idempotent via fixed IDs).
-- All rows are sandbox-only (sandbox_mode = true).

BEGIN;

-- ===================================================================
-- Event
-- ===================================================================
INSERT INTO events (
    id,
    title,
    description,
    start_date,
    end_date,
    personnel_needed,
    assets_needed,
    sandbox_mode,
    status,
    created_by,
    assigned_personnel,
    assigned_assets
) VALUES (
    'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1',
    '2026 Ohio Wing Cadet Encampment',
    'Ohio Wing Cadet Encampment training activities and support events.',
    '2026-06-05',
    '2026-06-14',
    120,
    15,
    true,
    'upcoming',
    'seed',
    '[]'::jsonb,
    '[]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    personnel_needed = EXCLUDED.personnel_needed,
    assets_needed = EXCLUDED.assets_needed,
    sandbox_mode = EXCLUDED.sandbox_mode,
    status = EXCLUDED.status,
    created_by = EXCLUDED.created_by;

-- ===================================================================
-- Locations
-- ===================================================================
INSERT INTO locations (id, name, street, city, state, zip, lat, lng, sandbox_mode)
VALUES
    ('5a77d2e8-2cbb-4a6a-bfb0-2a1c0f2f9c01', 'Encampment HQ', '2000 Air Base Rd', 'Springfield', 'OH', '45502', 39.9242, -83.8088, true),
    ('6b8f46e4-2ad7-4f85-8b1e-bc0c1cb7d102', 'Springfield Airfield', '1000 Flightline Dr', 'Springfield', 'OH', '45502', 39.9247, -83.8120, true),
    ('7c6a5b1c-1aa8-4d10-a401-2b77fcb9e203', 'Climbing Wall', '2500 Training Ln', 'Springfield', 'OH', '45502', 39.9231, -83.8053, true),
    ('8d3c7b2a-8b90-4cf4-9f9f-4c9d6d8e3404', 'National Museum of the USAF', '1100 Spaatz St', 'Dayton', 'OH', '45431', 39.7800, -84.1096, true),
    ('9e2f8a4f-6f49-4c8c-9cdd-1f1b7b021f05', 'STEM & Leadership Lab', '3000 Cadet Way', 'Springfield', 'OH', '45502', 39.9256, -83.8011, true)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    street = EXCLUDED.street,
    city = EXCLUDED.city,
    state = EXCLUDED.state,
    zip = EXCLUDED.zip,
    lat = EXCLUDED.lat,
    lng = EXCLUDED.lng,
    sandbox_mode = EXCLUDED.sandbox_mode;

-- ===================================================================
-- Activities (June 8-10, 2026)
-- ===================================================================
INSERT INTO activities (
    id,
    event_id,
    title,
    description,
    "column",
    activity_date,
    start_time,
    end_time,
    location_id,
    support_personnel_required,
    assets_required,
    assigned_personnel,
    assigned_assets,
    sandbox_mode
) VALUES
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1001', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'Orientation Flights (Powered)', 'CAP orientation flights for cadets.', 'Planning', '2026-06-08', '09:00', '12:00', '6b8f46e4-2ad7-4f85-8b1e-bc0c1cb7d102', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true),
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1002', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'Orientation Flights (Glider)', 'Glider orientation flights and safety briefings.', 'Planning', '2026-06-08', '13:00', '16:00', '6b8f46e4-2ad7-4f85-8b1e-bc0c1cb7d102', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true),
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1003', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'STEM & Leadership Lab', 'Hands-on STEM exercises and leadership scenarios.', 'Planning', '2026-06-08', '16:30', '18:00', '9e2f8a4f-6f49-4c8c-9cdd-1f1b7b021f05', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true),
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1004', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'Climbing Wall', 'Team building and confidence course.', 'Planning', '2026-06-09', '10:00', '12:00', '7c6a5b1c-1aa8-4d10-a401-2b77fcb9e203', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true),
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1005', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'Air Force Museum Tour', 'Guided tour of the National Museum of the USAF.', 'Planning', '2026-06-09', '13:00', '17:00', '8d3c7b2a-8b90-4cf4-9f9f-4c9d6d8e3404', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true),
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1006', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'Military Orientation Flights', 'Military orientation flights (orientation and safety).', 'Planning', '2026-06-10', '09:00', '12:00', '6b8f46e4-2ad7-4f85-8b1e-bc0c1cb7d102', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true),
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1007', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'Drill & Ceremonies Expo', 'Precision drill practice and evaluation.', 'Planning', '2026-06-10', '13:30', '15:30', '5a77d2e8-2cbb-4a6a-bfb0-2a1c0f2f9c01', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    "column" = EXCLUDED."column",
    activity_date = EXCLUDED.activity_date,
    start_time = EXCLUDED.start_time,
    end_time = EXCLUDED.end_time,
    location_id = EXCLUDED.location_id,
    sandbox_mode = EXCLUDED.sandbox_mode;

-- ===================================================================
-- Personnel (15 total, 70% full-week availability)
-- ===================================================================
INSERT INTO personnel (
    id,
    name,
    cap_id,
    rank,
    specialties,
    status,
    assigned_to,
    availability,
    sandbox_mode
) VALUES
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000001', 'Alex Morgan', '610101', 'C/2d Lt', 'Logistics', 'available', null, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000002', 'Jordan Lee', '610102', 'C/1st Lt', 'Operations', 'available', null, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000003', 'Taylor Reed', '610103', 'C/Capt', 'Safety', 'available', null, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000004', 'Riley Chen', '610104', 'C/2d Lt', 'Medical', 'available', null, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000005', 'Casey Patel', '610105', 'C/MSgt', 'Comms', 'available', null, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000006', 'Morgan Diaz', '610106', 'C/TSgt', 'Cadet Programs', 'available', null, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000007', 'Jamie Carter', '610107', 'C/SSgt', 'Logistics', 'available', null, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000008', 'Avery Scott', '610108', 'C/A1C', 'Public Affairs', 'available', null, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000009', 'Drew Simmons', '610109', 'C/SSgt', 'Transportation', 'available', null, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000010', 'Quinn Park', '610110', 'C/SMSgt', 'Logistics', 'available', null, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000011', 'Parker Woods', '610111', 'C/Capt', 'Operations', 'available', null, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000012', 'Skyler James', '610112', 'C/2d Lt', 'Admin', 'available', null, '[{"label":"Morning Block","start_date":"2026-06-06","end_date":"2026-06-10","start_time":"07:00","end_time":"12:00"},{"label":"Late Week","start_date":"2026-06-12","end_date":"2026-06-14","start_time":"12:00","end_time":"20:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000013', 'Rowan Blake', '610113', 'C/TSgt', 'Comms', 'available', null, '[{"label":"Midweek","start_date":"2026-06-08","end_date":"2026-06-09","start_time":"06:00","end_time":"18:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000014', 'Logan Rivera', '610114', 'C/SSgt', 'Medical', 'available', null, '[{"label":"Evenings","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"17:00","end_time":"22:00"}]'::jsonb, true),
    ('c1f5a1b0-1111-4e6a-8b11-8e1c0a000015', 'Emerson Knight', '610115', 'C/A1C', 'Transportation', 'available', null, '[{"label":"Early Week","start_date":"2026-06-05","end_date":"2026-06-07","start_time":"06:00","end_time":"22:00"},{"label":"Late Week","start_date":"2026-06-11","end_date":"2026-06-13","start_time":"06:00","end_time":"22:00"}]'::jsonb, true)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    cap_id = EXCLUDED.cap_id,
    rank = EXCLUDED.rank,
    specialties = EXCLUDED.specialties,
    status = EXCLUDED.status,
    assigned_to = EXCLUDED.assigned_to,
    availability = EXCLUDED.availability,
    sandbox_mode = EXCLUDED.sandbox_mode;

-- ===================================================================
-- Assets (15 total: 6x 12-passenger vans, 6x 15-passenger vans, 3x C182)
-- ===================================================================
INSERT INTO assets (
    id,
    name,
    type,
    details,
    asset_id,
    status,
    assigned_to,
    assigned_personnel,
    availability,
    sandbox_mode
) VALUES
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000001', 'Van 12P-01', 'Van', '12-passenger van', '720101', 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000002', 'Van 12P-02', 'Van', '12-passenger van', '720102', 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000003', 'Van 12P-03', 'Van', '12-passenger van', '720103', 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000004', 'Van 12P-04', 'Van', '12-passenger van', '720104', 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000005', 'Van 12P-05', 'Van', '12-passenger van', '720105', 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000006', 'Van 12P-06', 'Van', '12-passenger van', '720106', 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000007', 'Van 15P-01', 'Van', '15-passenger van', '730101', 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000008', 'Van 15P-02', 'Van', '15-passenger van', '730102', 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000009', 'Van 15P-03', 'Van', '15-passenger van', '730103', 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000010', 'Van 15P-04', 'Van', '15-passenger van', '730104', 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000011', 'Van 15P-05', 'Van', '15-passenger van', '730105', 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000012', 'Van 15P-06', 'Van', '15-passenger van', '730106', 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000013', 'C182 Skyhawk 01', 'C182', 'Cessna 182 (Tail No. TBD)', null, 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000014', 'C182 Skyhawk 02', 'C182', 'Cessna 182 (Tail No. TBD)', null, 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true),
    ('d2a7e1f0-2001-4a62-9b11-1a1c0b000015', 'C182 Skyhawk 03', 'C182', 'Cessna 182 (Tail No. TBD)', null, 'available', null, '[]'::jsonb, '[{"label":"All Week","start_date":"2026-06-05","end_date":"2026-06-14","start_time":"06:00","end_time":"22:00"}]'::jsonb, true)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    details = EXCLUDED.details,
    asset_id = EXCLUDED.asset_id,
    status = EXCLUDED.status,
    assigned_to = EXCLUDED.assigned_to,
    assigned_personnel = EXCLUDED.assigned_personnel,
    availability = EXCLUDED.availability,
    sandbox_mode = EXCLUDED.sandbox_mode;

COMMIT;
