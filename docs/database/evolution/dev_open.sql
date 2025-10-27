CREATE POLICY dev_open_fragments ON fragments FOR ALL TO authenticated USING (true) WITH CHECK (true);
