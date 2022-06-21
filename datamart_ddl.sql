CREATE TABLE analysis.dm_rfm_segments (
	user_id _int4  NOT NULL,
	recency _int2 CHECK (recency <= 5) NULL,
	frequency _int2 CHECK (frequency <= 5) NULL,
	monetary_value _int2 CHECK (monetary_value <= 5)  NULL
);



