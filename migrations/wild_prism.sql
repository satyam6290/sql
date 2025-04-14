/*
  # Update portfolios table policies

  This migration adds Row Level Security (RLS) policies to the existing portfolios table.

  1. Security Changes
    - Enable RLS on portfolios table
    - Add policies for:
      - Users can read their own portfolio
      - Users can create their own portfolio
      - Users can update their own portfolio
      - Public read access for all portfolios
*/

-- Enable RLS if not already enabled
DO $$ 
BEGIN
  ALTER TABLE portfolios ENABLE ROW LEVEL SECURITY;
EXCEPTION
  WHEN others THEN
    NULL;
END $$;

-- Drop existing policies if they exist
DO $$ 
BEGIN
  DROP POLICY IF EXISTS "Users can read own portfolio" ON portfolios;
  DROP POLICY IF EXISTS "Users can create own portfolio" ON portfolios;
  DROP POLICY IF EXISTS "Users can update own portfolio" ON portfolios;
  DROP POLICY IF EXISTS "Anyone can view portfolios" ON portfolios;
EXCEPTION
  WHEN others THEN
    NULL;
END $$;

-- Create new policies
CREATE POLICY "Users can read own portfolio"
  ON portfolios
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create own portfolio"
  ON portfolios
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own portfolio"
  ON portfolios
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Anyone can view portfolios"
  ON portfolios
  FOR SELECT
  TO anon
  USING (true);