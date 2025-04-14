/*
  # Add username field to portfolios

  1. Changes
    - Add `username` column to `portfolios` table
    - Add unique constraint on `username` column
    - Add validation to ensure username follows proper format (alphanumeric with hyphens and underscores)
  
  2. Purpose
    - Enable unique shareable links based on username
    - Allow users to have a more memorable URL for sharing
*/

-- Add username column if it doesn't exist
ALTER TABLE portfolios
ADD COLUMN IF NOT EXISTS username text;

-- Add unique constraint on username
ALTER TABLE portfolios
ADD CONSTRAINT portfolios_username_unique UNIQUE (username);

-- Add check constraint to ensure username follows proper format
ALTER TABLE portfolios
ADD CONSTRAINT username_format CHECK (
  username ~ '^[a-zA-Z0-9_-]+$'
);