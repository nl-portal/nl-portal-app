/*
 * Copyright 2015-2021 Ritense BV, the Netherlands.
 *
 * Licensed under EUPL, Version 1.2 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

INSERT INTO public.accounts_user(id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined)
VALUES(1, 'pbkdf2_sha256$600000$8R5PtLVB2cWBCB3lBoTrd2$zJ4IalwmR5kNrX9yDl4W+M2F94Z1D8KtZRH/lNrXeHY=', null, true, 'admin', '', '', 'admin@example.com', true, true, now());

INSERT INTO public.token_tokenauth (id, token, contact_person, email, organization, last_modified, created, application, administration, identifier)
VALUES (10, 'ac045222c9e7cde8120b48735560f9b920bb58cd', 'Admin', 'admin@example.com', '', '2024-09-06 07:26:53.703312 +00:00', '2024-09-06 07:26:53.703384 +00:00', '', '', 'test_token');

INSERT INTO public.klantinteracties_partij (id, bezoekadres_nummeraanduiding_id, bezoekadres_adresregel1, bezoekadres_adresregel2, bezoekadres_adresregel3, bezoekadres_land, correspondentieadres_nummeraanduiding_id, correspondentieadres_adresregel1, correspondentieadres_adresregel2, correspondentieadres_adresregel3, correspondentieadres_land, uuid, nummer, interne_notitie, soort_partij, indicatie_geheimhouding, voorkeurstaal, indicatie_actief, voorkeurs_digitaal_adres_id, voorkeurs_rekeningnummer_id, bezoekadres_huisnummer, bezoekadres_huisnummertoevoeging, bezoekadres_postcode, bezoekadres_stad, bezoekadres_straatnaam, correspondentieadres_huisnummer, correspondentieadres_huisnummertoevoeging, correspondentieadres_postcode, correspondentieadres_stad, correspondentieadres_straatnaam)
VALUES
    (100, '', '', '', '', '', '', '', '', '', '', 'c264d2cf-63a7-4280-bcee-6ec30e822769', '11111', '', 'persoon', true, 'nld', true, null, null, 1, '', '', '', '', 1, '', '', '', ''),
    (101, '', '', '', '', '', '', '', '', '', '', '042ed68f-9428-41b8-a8b7-f2bfb1e6bc3d', '22222', '', 'organisatie', true, 'nld', true, null, null, 1, '', '', '', '', 1, '', '', '', '');

INSERT INTO public.klantinteracties_partijidentificator (id, uuid, andere_partij_identificator, partij_identificator_code_objecttype, partij_identificator_code_soort_object_id, partij_identificator_object_id, partij_identificator_code_register, partij_id, sub_identificator_van_id)
VALUES (200, 'fc707204-faf6-4911-9af8-55174808bb94', '', 'natuurlijk_persoon', 'bsn', '999993847', 'brp', 100, null),
       (201, 'b945acd0-7d92-4277-b765-b445b47e5c40', '', 'niet_natuurlijk_persoon', 'kvk_nummer', '14127293', 'hr', 101, null),
       (202, '71cf06c1-70ee-4354-9658-d33b167e873d', '', 'vestiging', 'vestigingsnummer', '000037143557', 'hr', 101, 201);

INSERT INTO public.klantinteracties_persoon (id, contactnaam_voorletters, contactnaam_voornaam, contactnaam_voorvoegsel_achternaam, contactnaam_achternaam, partij_id)
VALUES(900, 'V','Vincent', 'van', 'Beek', 100);

INSERT INTO public.klantinteracties_organisatie (id, naam, partij_id)
VALUES(901, 'Ritense', 101);

INSERT INTO public.klantinteracties_klantcontact (id, uuid, nummer, kanaal, onderwerp, inhoud, indicatie_contact_gelukt, taal, vertrouwelijk, plaatsgevonden_op)
VALUES (400, '482a8529-0ebd-4424-83a9-b9f88335673d', '0000000333', 'E-mail', 'Vraag over status Bezwaar', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut aliquam velit.', true, 'nld', true, '2025-03-06 11:02:24+00'),
       (401, '652167f2-56cb-4ed4-8e33-91241081aa44', '0000000334', 'Telefoon', 'Klacht', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut aliquam velit.', true, 'nld', true, '2025-10-29 11:02:24+00');

INSERT INTO public.klantinteracties_onderwerpobject(id, onderwerpobjectidentificator_object_id, uuid, klantcontact_id, was_klantcontact_id, onderwerpobjectidentificator_code_objecttype, onderwerpobjectidentificator_code_register, onderwerpobjectidentificator_code_soort_object_id)
VALUES (600, '729a9bdf-ea81-4a8d-b0ec-9b516ba26cc5', '33489b0e-5954-4fc7-a3fd-d91f00ec0aa3', 400, null, 'zaak', 'open-zaak', 'uuid'),
       (601, '727a510b-68cb-48d7-a6a5-f24bf1acecbe', '4356aed6-1f11-4f18-9c94-30c36222c7aa', 401, null, 'zaak', 'open-zaak', 'uuid');

INSERT INTO public.klantinteracties_betrokkene (id, bezoekadres_nummeraanduiding_id, bezoekadres_adresregel1, bezoekadres_adresregel2, bezoekadres_adresregel3, bezoekadres_land, correspondentieadres_nummeraanduiding_id, correspondentieadres_adresregel1, correspondentieadres_adresregel2, correspondentieadres_adresregel3, correspondentieadres_land, contactnaam_voorletters, contactnaam_voornaam, contactnaam_voorvoegsel_achternaam, contactnaam_achternaam, uuid, rol, organisatienaam, initiator, klantcontact_id, partij_id, bezoekadres_huisnummer, bezoekadres_huisnummertoevoeging, bezoekadres_postcode, bezoekadres_stad, bezoekadres_straatnaam, correspondentieadres_huisnummer, correspondentieadres_huisnummertoevoeging, correspondentieadres_postcode, correspondentieadres_stad, correspondentieadres_straatnaam)
VALUES(300, '0000000000000001','King Olivereiland 64, 2551JV ''s-Gravenhage', '', '', 'nl', '0000000000000001', 'King Olivereiland 64, 2551JV ''s-Gravenhage', '', '', 'nl', 'D', 'Merel', '', 'Kooyman', '7694c26b-8118-43a0-b0c1-37673f0f46e4', 'klant', '', true, 400, 100, 1, '', '', '','', 1, '', '', '', ''),
      (301, '22222','King Olivereiland 64, 2551JV ''s-Gravenhage', '', '', 'nl', '22222', 'King Olivereiland 64, 2551JV ''s-Gravenhage', '', '', 'nl', 'D', 'Merel', '', 'Kooyman', '0af24036-2172-4d49-9be9-8368d5f97045', 'klant', '', true, 401, 101, 1, '', '', '','', 1, '', '', '', '');

INSERT INTO public.klantinteracties_digitaaladres (id, uuid, soort_digitaal_adres, adres, omschrijving, betrokkene_id, partij_id, is_standaard_adres, referentie, verificatie_datum)
VALUES(500, 'a5f323d8-8c87-43c2-990b-eae03d721adf', 'email', 'm.kooyman@example.com', '', 300, 100, false, 'portaal', '2025-08-06'),
      (501, '3b006b45-afa9-44ed-a690-32c545924a28', 'telefoonnummer', '0701234567', '', 300, 100, false, '', null),
      (502, 'da80dc1c-bf9b-449f-80e6-2906e66db0a7', 'telefoonnummer', '0701234567', '', 300, 101, false, 'portaal', null);

SELECT pg_catalog.setval('public.klantinteracties_partij_id_seq', 2, true);
SELECT pg_catalog.setval('public.klantinteracties_partijidentificator_id_seq', 3, true);
SELECT pg_catalog.setval('public.klantinteracties_persoon_id_seq', 1, true);
SELECT pg_catalog.setval('public.klantinteracties_organisatie_id_seq', 1, true);
SELECT pg_catalog.setval('public.klantinteracties_klantcontact_id_seq', 2, true);
SELECT pg_catalog.setval('public.klantinteracties_onderwerpobject_id_seq', 1, true);
SELECT pg_catalog.setval('public.klantinteracties_betrokkene_id_seq', 1, true);
SELECT pg_catalog.setval('public.klantinteracties_digitaaladres_id_seq', 4, true);
