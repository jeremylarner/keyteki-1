-- Table: public."Motd"

-- DROP TABLE public."Motd";

CREATE TABLE public."Motd"
(
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "PosterId" integer NOT NULL,
    "Text" text COLLATE pg_catalog."default",
    "Type" text COLLATE pg_catalog."default",
    "PostedTime" timestamp without time zone NOT NULL,
    CONSTRAINT "PK_Motd" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Motd_Users_PosterId" FOREIGN KEY ("PosterId")
        REFERENCES public."Users" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE public."Motd"
    OWNER to keyteki;
-- Index: IX_Motd_PosterId

-- DROP INDEX public."IX_Motd_PosterId";

CREATE INDEX "IX_Motd_PosterId"
    ON public."Motd" USING btree
    ("PosterId" ASC NULLS LAST)
    TABLESPACE pg_default;