/*
  # Create portfolio time slots table
  
  1. New Tables
    - portfolio_time_slots: Stores available time slots for bookings
      - id (uuid, primary key)
      - portfolio_id (uuid, references portfolios)
      - day_of_week (integer)
      - start_time (time)
      - end_time (time)
      - duration (integer)
      - is_available (boolean)
      - sort_order (integer)
      
  2. Security
    - Enable RLS
    - Add policies for CRUD operations
*/

CREATE TABLE IF NOT EXISTS portfolio_time_slots (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  portfolio_id uuid REFERENCES portfolios(id) ON DELETE CASCADE,
  day_of_week integer NOT NULL,
  start_time time NOT NULL,
  end_time time NOT NULL,
  duration integer NOT NULL,
  is_available boolean DEFAULT true,
  sort_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE portfolio_time_slots ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own time slots"
  ON portfolio_time_slots
  FOR SELECT
  TO authenticated
  USING (
    portfolio_id IN (
      SELECT id FROM portfolios WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Users can create time slots for their portfolio"
  ON portfolio_time_slots
  FOR INSERT
  TO authenticated
  WITH CHECK (
    portfolio_id IN (
      SELECT id FROM portfolios WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Users can update their own time slots"
  ON portfolio_time_slots
  FOR UPDATE
  TO authenticated
  USING (
    portfolio_id IN (
      SELECT id FROM portfolios WHERE user_id = auth.uid()
    )
  )
  WITH CHECK (
    portfolio_id IN (
      SELECT id FROM portfolios WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Users can delete their own time slots"
  ON portfolio_time_slots
  FOR DELETE
  TO authenticated
  USING (
    portfolio_id IN (
      SELECT id FROM portfolios WHERE user_id = auth.uid()
    )
  );

-- Create trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_portfolio_time_slots_updated_at
  BEFORE UPDATE
  ON portfolio_time_slots
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();