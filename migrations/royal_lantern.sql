/*
  # Add cover photo support to portfolios

  1. Changes
    - Add `cover_url` column to portfolios table
    - Add storage bucket for covers
    - Add storage policies for cover uploads

  2. Security
    - Enable public read access to covers
    - Allow authenticated users to upload their own covers
*/

-- Create a bucket for storing covers
INSERT INTO storage.buckets (id, name, public) 
VALUES ('covers', 'covers', true);

-- Add cover_url column to portfolios
ALTER TABLE portfolios
ADD COLUMN IF NOT EXISTS cover_url text;

-- Storage policies for covers bucket
CREATE POLICY "Cover images are publicly accessible"
ON storage.objects FOR SELECT
TO public
USING ( bucket_id = 'covers' );

CREATE POLICY "Users can upload covers"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK ( bucket_id = 'covers' AND (auth.uid())::text = (SPLIT_PART(name, '/', 1)) );

CREATE POLICY "Users can update own cover"
ON storage.objects FOR UPDATE
TO authenticated
USING ( bucket_id = 'covers' AND (auth.uid())::text = (SPLIT_PART(name, '/', 1)) )
WITH CHECK ( bucket_id = 'covers' AND (auth.uid())::text = (SPLIT_PART(name, '/', 1)) );

CREATE POLICY "Users can delete own cover"
ON storage.objects FOR DELETE
TO authenticated
USING ( bucket_id = 'covers' AND (auth.uid())::text = (SPLIT_PART(name, '/', 1)) );