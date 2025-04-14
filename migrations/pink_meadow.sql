/*
  # Add unique constraint to portfolios table

  1. Changes
    - Add unique constraint on user_id to ensure each user can only have one portfolio
    - Drop any duplicate portfolios keeping only the most recently updated one

  2. Security
    - No changes to existing security policies
*/

-- First, remove any duplicate portfolios keeping only the most recent one
WITH duplicates AS (
  SELECT user_id, MAX(updated_at) as max_updated_at
  FROM portfolios
  GROUP BY user_id
  HAVING COUNT(*) > 1
)
DELETE FROM portfolios p
WHERE EXISTS (
  SELECT 1
  FROM duplicates d
  WHERE p.user_id = d.user_id
  AND p.updated_at < d.max_updated_at
);

-- Add unique constraint
ALTER TABLE portfolios
ADD CONSTRAINT portfolios_user_id_unique UNIQUE (user_id);