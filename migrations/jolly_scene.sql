/*
  # Create Storage Buckets
  
  1. New Storage Buckets
    - `testimonials`: For storing testimonial author avatars
    - `projects`: For storing project images and media
    
  2. Security Policies
    - Public read access for both buckets
    - Write access restricted to authenticated users for their own files
    
  3. Description
    - Creates storage buckets for testimonials and projects
    - Sets up appropriate security policies for file access
    - Ensures users can only manage their own files
*/

-- Create testimonials bucket
INSERT INTO storage.buckets (id, name, public)
VALUES ('testimonials', 'testimonials', true)
ON CONFLICT (id) DO NOTHING;

-- Create projects bucket
INSERT INTO storage.buckets (id, name, public)
VALUES ('projects', 'projects', true)
ON CONFLICT (id) DO NOTHING;

-- Policy for reading testimonial files (public)
CREATE POLICY "Testimonial images are publicly accessible"
ON storage.objects FOR SELECT
USING (bucket_id = 'testimonials');

-- Policy for uploading testimonial files (authenticated users only)
CREATE POLICY "Users can upload testimonial images"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'testimonials' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Policy for updating/deleting testimonial files (own files only)
CREATE POLICY "Users can update/delete their testimonial images"
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

-- Policy for reading project files (public)
CREATE POLICY "Project images are publicly accessible"
ON storage.objects FOR SELECT
USING (bucket_id = 'projects');

-- Policy for uploading project files (authenticated users only)
CREATE POLICY "Users can upload project images"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'projects'
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Policy for updating/deleting project files (own files only)
CREATE POLICY "Users can update/delete their project images"
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