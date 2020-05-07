-- Table: public."Decks"

-- DROP TABLE public."Decks";

CREATE TABLE public."Decks"
(
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "UserId" integer NOT NULL,
    "Uuid" text COLLATE pg_catalog."default",
    "Identity" text COLLATE pg_catalog."default",
    "Name" text COLLATE pg_catalog."default",
    "Banned" boolean NOT NULL,
    "IncludeInSealed" boolean NOT NULL,
    "LastUpdated" timestamp without time zone NOT NULL,
    "Verified" boolean,
    "ExpansionId" integer NOT NULL,
    "Flagged" boolean,
    CONSTRAINT "PK_Decks" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Decks_Expansions_ExpansionId" FOREIGN KEY ("ExpansionId")
        REFERENCES public."Expansions" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT "FK_Decks_Users_UserId" FOREIGN KEY ("UserId")
        REFERENCES public."Users" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE public."Decks"
    OWNER to keyteki;
-- Index: IX_Decks_ExpansionId

-- DROP INDEX public."IX_Decks_ExpansionId";

CREATE INDEX "IX_Decks_ExpansionId"
    ON public."Decks" USING btree
    ("ExpansionId" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: IX_Decks_Identity_UserId

-- DROP INDEX public."IX_Decks_Identity_UserId";

CREATE UNIQUE INDEX "IX_Decks_Identity_UserId"
    ON public."Decks" USING btree
    ("Identity" COLLATE pg_catalog."default" ASC NULLS LAST, "UserId" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: IX_Decks_Name

-- DROP INDEX public."IX_Decks_Name";

CREATE INDEX "IX_Decks_Name"
    ON public."Decks" USING btree
    ("Name" COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: IX_Decks_UserId

-- DROP INDEX public."IX_Decks_UserId";

CREATE INDEX "IX_Decks_UserId"
    ON public."Decks" USING btree
    ("UserId" ASC NULLS LAST)
    TABLESPACE pg_default;