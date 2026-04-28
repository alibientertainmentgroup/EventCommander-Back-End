-- Org chart positions for encampment command structure

CREATE TABLE IF NOT EXISTS org_chart_positions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    cap_id TEXT NOT NULL,
    position_title TEXT NOT NULL,
    reports_to_cap_id TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS org_chart_positions_event_idx ON org_chart_positions(event_id);
CREATE INDEX IF NOT EXISTS org_chart_positions_reports_idx ON org_chart_positions(reports_to_cap_id);

ALTER TABLE org_chart_positions ENABLE ROW LEVEL SECURITY;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_policies
        WHERE schemaname = 'public'
          AND tablename = 'org_chart_positions'
          AND policyname = 'Allow all operations on org_chart_positions'
    ) THEN
        CREATE POLICY "Allow all operations on org_chart_positions"
            ON org_chart_positions
            FOR ALL
            USING (true);
    END IF;
END $$;
