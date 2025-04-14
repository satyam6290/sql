/*
  # Create portfolios table

  1. New Tables
    - `portfolios`
      - `id` (uuid, primary key)
      - `user_id` (uuid, references auth.users)
      - `full_name` (text)
      - `profession` (text)
      - `bio` (text)
      - `skills` (text)
      - `experience` (text)
      - `projects` (text)
      - `contact_email` (text)
      - `github` (text)
      - `linkedin` (text)
      - `website` (text)
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)

  2. Security
    - Enable RLS on `portfolios` table
    - Add policies for:
      - Users can read their own portfolio
      - Users can create their own portfolio
      - Users can update their own portfolio
      - Anyone can read any portfolio (for public viewing)
*/

CREATE TABLE portfolios (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users NOT NULL,
  full_name text NOT NULL,
  profession text NOT NULL,
  bio text NOT NULL,
  skills text NOT NULL,
  experience text NOT NULL,
  projects text NOT NULL,
  contact_email text NOT NULL,
  github text,
  linkedin text,
  website text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE portfolios ENABLE ROW LEVEL SECURITY;

-- Allow users to read their own portfolio
CREATE POLICY "Users can read own portfolio"
  ON portfolios
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

-- Allow users to create their own portfolio
CREATE POLICY "Users can create own portfolio"
  ON portfolios
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Allow users to update their own portfolio
CREATE POLICY "Users can update own portfolio"
  ON portfolios
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Allow public read access to all portfolios
CREATE POLICY "Anyone can view portfolios"
  ON portfolios
  FOR SELECT
  TO anon
  USING (true);