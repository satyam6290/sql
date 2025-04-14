/*
  # Add avatar support to portfolios

  1. Changes
    - Add `avatar_url` column to portfolios table
    - Add storage bucket for avatars
    - Add storage policies for avatar uploads

  2. Security
    - Enable public read access to avatars
    - Allow authenticated users to upload their own avatars
*/

-- Create a bucket for storing avatars
INSERT INTO storage.buckets (id, name, public) 
VALUES ('avatars', 'avatars', true);

-- Add avatar_url column to portfolios
ALTER TABLE portfolios
ADD COLUMN IF NOT EXISTS avatar_url text;

-- Storage policies for avatars bucket
CREATE POLICY "Avatar images are publicly accessible"
ON storage.objects FOR SELECT
TO public
USING ( bucket_id = 'avatars' );

CREATE POLICY "Users can upload avatars"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK ( bucket_id = 'avatars' AND (auth.uid())::text = (SPLIT_PART(name, '/', 1)) );

CREATE POLICY "Users can update own avatar"
ON storage.objects FOR UPDATE
TO authenticated
USING ( bucket_id = 'avatars' AND (auth.uid())::text = (SPLIT_PART(name, '/', 1)) )
WITH CHECK ( bucket_id = 'avatars' AND (auth.uid())::text = (SPLIT_PART(name, '/', 1)) );

CREATE POLICY "Users can delete own avatar"
ON storage.objects FOR DELETE
TO authenticated
USING ( bucket_id = 'avatars' AND (auth.uid())::text = (SPLIT_PART(name, '/', 1)) );