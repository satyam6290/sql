/*
  # Create Storage Buckets
  
  1. New Storage Buckets
    - `testimonials`: For storing testimonial author avatars
    - `projects`: For storing project images and media
    - `blog_images`: For storing blog post images
    - `avatars`: For storing user profile avatars
    - `covers`: For storing portfolio cover images
    
  2. Security Policies
    - Public read access for all buckets
    - Write access restricted to authenticated users for their own files
*/

-- Create buckets
INSERT INTO storage.buckets (id, name, public)
VALUES 
  ('testimonials', 'testimonials', true),
  ('projects', 'projects', true),
  ('blog_images', 'blog_images', true),
  ('avatars', 'avatars', true),
  ('covers', 'covers', true)
ON CONFLICT (id) DO NOTHING;

-- Testimonials bucket policies
CREATE POLICY "Testimonial images are publicly accessible"
ON storage.objects FOR SELECT
USING (bucket_id = 'testimonials');

CREATE POLICY "Users can upload testimonial images"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'testimonials' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

CREATE POLICY "Users can update their testimonial images"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'testimonials'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

CREATE POLICY "Users can delete their testimonial images"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'testimonials'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Projects bucket policies
CREATE POLICY "Project images are publicly accessible"
ON storage.objects FOR SELECT
USING (bucket_id = 'projects');

CREATE POLICY "Users can upload project images"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'projects'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

CREATE POLICY "Users can update their project images"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'projects'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

CREATE POLICY "Users can delete their project images"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'projects'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Blog images bucket policies
CREATE POLICY "Blog images are publicly accessible"
ON storage.objects FOR SELECT
USING (bucket_id = 'blog_images');

CREATE POLICY "Users can upload blog images"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'blog_images'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

CREATE POLICY "Users can update their blog images"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'blog_images'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

CREATE POLICY "Users can delete their blog images"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'blog_images'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Avatars bucket policies
CREATE POLICY "Avatar images are publicly accessible"
ON storage.objects FOR SELECT
USING (bucket_id = 'avatars');

CREATE POLICY "Users can upload avatar images"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'avatars'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

CREATE POLICY "Users can update their avatar images"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'avatars'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

CREATE POLICY "Users can delete their avatar images"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'avatars'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Covers bucket policies
CREATE POLICY "Cover images are publicly accessible"
ON storage.objects FOR SELECT
USING (bucket_id = 'covers');

CREATE POLICY "Users can upload cover images"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'covers'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

CREATE POLICY "Users can update their cover images"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'covers'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

CREATE POLICY "Users can delete their cover images"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'covers'
  AND (storage.foldername(name))[1] = auth.uid()::text
);