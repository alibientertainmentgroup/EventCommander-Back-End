ALTER TABLE public.org_chart_positions
ADD COLUMN IF NOT EXISTS chart_type TEXT DEFAULT 'senior';

UPDATE public.org_chart_positions
SET chart_type = 'senior'
WHERE chart_type IS NULL;
