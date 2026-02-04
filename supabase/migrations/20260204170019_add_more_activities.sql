-- ===================================================================
-- Add additional sandbox activities for 2026-06-08
-- ===================================================================

BEGIN;

-- Ensure required locations exist (idempotent)
INSERT INTO locations (id, name, street, city, state, zip, lat, lng, sandbox_mode)
VALUES
    ('5a77d2e8-2cbb-4a6a-bfb0-2a1c0f2f9c01', 'Encampment HQ', '2000 Air Base Rd', 'Springfield', 'OH', '45502', 39.9242, -83.8088, true),
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
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1011', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'Safety Briefing', 'Encampment-wide safety and risk management briefing.', 'Planning', '2026-06-08', '07:30', '08:15', '5a77d2e8-2cbb-4a6a-bfb0-2a1c0f2f9c01', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true),
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1012', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'PT & Fitness Training', 'Physical training and fitness assessment.', 'Planning', '2026-06-08', '06:15', '07:15', '5a77d2e8-2cbb-4a6a-bfb0-2a1c0f2f9c01', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true),
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1013', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'Drill & Ceremonies (Basics)', 'Foundational drill instruction and practice.', 'Planning', '2026-06-08', '10:00', '11:30', '5a77d2e8-2cbb-4a6a-bfb0-2a1c0f2f9c01', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true),
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1014', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'Leadership Seminar', 'Cadet leadership fundamentals and teamwork.', 'Planning', '2026-06-08', '11:45', '12:45', '9e2f8a4f-6f49-4c8c-9cdd-1f1b7b021f05', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true),
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1015', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'Aerospace Education Block', 'Aerospace education lesson and discussion.', 'Planning', '2026-06-08', '14:00', '15:00', '9e2f8a4f-6f49-4c8c-9cdd-1f1b7b021f05', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true),
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1016', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'First Aid/CPR Overview', 'Basic first aid and CPR overview for cadets.', 'Planning', '2026-06-08', '15:15', '16:15', '9e2f8a4f-6f49-4c8c-9cdd-1f1b7b021f05', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true),
    ('a0c7a9f1-5f9d-4d12-8a1f-2f5c9b4a1017', 'b6df4f4b-3a2a-4f47-8cb9-6f7b8aa0d3c1', 'Barracks Inspection Prep', 'Uniform and barracks standards review.', 'Planning', '2026-06-08', '18:30', '19:15', '5a77d2e8-2cbb-4a6a-bfb0-2a1c0f2f9c01', '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, true)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    "column" = EXCLUDED."column",
    activity_date = EXCLUDED.activity_date,
    start_time = EXCLUDED.start_time,
    end_time = EXCLUDED.end_time,
    location_id = EXCLUDED.location_id,
    sandbox_mode = EXCLUDED.sandbox_mode;

COMMIT;
