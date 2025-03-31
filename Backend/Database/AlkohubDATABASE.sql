PGDMP  	    "                }           alkohub    17.2    17.2 @    h           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            i           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            j           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            k           1262    16388    alkohub    DATABASE     i   CREATE DATABASE alkohub WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE alkohub;
                     postgres    false            �            1259    16436    alkohole    TABLE       CREATE TABLE public.alkohole (
    id integer NOT NULL,
    rodzaj_alkoholu integer,
    nazwa_alkoholu character varying(30) NOT NULL,
    opis_alkoholu text,
    zawartosc_procentowa double precision,
    rok_produkcji integer,
    image_url character varying(255)
);
    DROP TABLE public.alkohole;
       public         heap r       postgres    false            �            1259    16435    alkohole_id_seq    SEQUENCE     �   CREATE SEQUENCE public.alkohole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.alkohole_id_seq;
       public               postgres    false    224            l           0    0    alkohole_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.alkohole_id_seq OWNED BY public.alkohole.id;
          public               postgres    false    223            �            1259    16467    historia    TABLE     
  CREATE TABLE public.historia (
    id_uzytkownika integer NOT NULL,
    id_alkoholu integer NOT NULL,
    data timestamp(0) without time zone NOT NULL,
    ilosc_wypitego_ml integer,
    CONSTRAINT historia_ilosc_wypitego_ml_check CHECK ((ilosc_wypitego_ml > 0))
);
    DROP TABLE public.historia;
       public         heap r       postgres    false            �            1259    16449    opinie    TABLE       CREATE TABLE public.opinie (
    id_alkoholu integer NOT NULL,
    id_uzytkownika integer NOT NULL,
    znacznik_czasu timestamp without time zone NOT NULL,
    ocena integer,
    recenzja text,
    CONSTRAINT opinie_ocena_check CHECK (((ocena >= 1) AND (ocena <= 5)))
);
    DROP TABLE public.opinie;
       public         heap r       postgres    false            �            1259    16484    osiagniecia    TABLE     *  CREATE TABLE public.osiagniecia (
    id_osiagniecia integer NOT NULL,
    rodzaj_alkoholu integer,
    nazwa_osiagniecia character varying(30) NOT NULL,
    opis_osiagniecia text,
    ilosc_wymagana_ml integer,
    CONSTRAINT osiagniecia_ilosc_wymagana_ml_check CHECK ((ilosc_wymagana_ml > 0))
);
    DROP TABLE public.osiagniecia;
       public         heap r       postgres    false            �            1259    16483    osiagniecia_id_osiagniecia_seq    SEQUENCE     �   CREATE SEQUENCE public.osiagniecia_id_osiagniecia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.osiagniecia_id_osiagniecia_seq;
       public               postgres    false    228            m           0    0    osiagniecia_id_osiagniecia_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.osiagniecia_id_osiagniecia_seq OWNED BY public.osiagniecia.id_osiagniecia;
          public               postgres    false    227            �            1259    16408    rangi_uzytkownika    TABLE     m   CREATE TABLE public.rangi_uzytkownika (
    id integer NOT NULL,
    nazwa character varying(15) NOT NULL
);
 %   DROP TABLE public.rangi_uzytkownika;
       public         heap r       postgres    false            �            1259    16407    rangi_uzytkownika_id_seq    SEQUENCE     �   CREATE SEQUENCE public.rangi_uzytkownika_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.rangi_uzytkownika_id_seq;
       public               postgres    false    218            n           0    0    rangi_uzytkownika_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.rangi_uzytkownika_id_seq OWNED BY public.rangi_uzytkownika.id;
          public               postgres    false    217            �            1259    16429    rodzaje_alkoholi    TABLE     l   CREATE TABLE public.rodzaje_alkoholi (
    id integer NOT NULL,
    nazwa character varying(15) NOT NULL
);
 $   DROP TABLE public.rodzaje_alkoholi;
       public         heap r       postgres    false            �            1259    16428    rodzaje_alkoholi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.rodzaje_alkoholi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.rodzaje_alkoholi_id_seq;
       public               postgres    false    222            o           0    0    rodzaje_alkoholi_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.rodzaje_alkoholi_id_seq OWNED BY public.rodzaje_alkoholi.id;
          public               postgres    false    221            �            1259    16498    ukonczone_osiagniecia    TABLE     �   CREATE TABLE public.ukonczone_osiagniecia (
    id_osiagniecia integer NOT NULL,
    id_uzytkownika integer NOT NULL,
    data date
);
 )   DROP TABLE public.ukonczone_osiagniecia;
       public         heap r       postgres    false            �            1259    16513    ulubione    TABLE     h   CREATE TABLE public.ulubione (
    id_uzytkownika integer NOT NULL,
    id_alkoholu integer NOT NULL
);
    DROP TABLE public.ulubione;
       public         heap r       postgres    false            �            1259    16415    uzytkownicy    TABLE       CREATE TABLE public.uzytkownicy (
    id integer NOT NULL,
    ranga integer,
    nazwa character varying(15) NOT NULL,
    haslo character varying(150) NOT NULL,
    waga double precision,
    wiek integer,
    plec boolean,
    mail character varying(50)
);
    DROP TABLE public.uzytkownicy;
       public         heap r       postgres    false            �            1259    16414    uzytkownicy_id_seq    SEQUENCE     �   CREATE SEQUENCE public.uzytkownicy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.uzytkownicy_id_seq;
       public               postgres    false    220            p           0    0    uzytkownicy_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.uzytkownicy_id_seq OWNED BY public.uzytkownicy.id;
          public               postgres    false    219            �           2604    16439    alkohole id    DEFAULT     j   ALTER TABLE ONLY public.alkohole ALTER COLUMN id SET DEFAULT nextval('public.alkohole_id_seq'::regclass);
 :   ALTER TABLE public.alkohole ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    223    224    224            �           2604    16487    osiagniecia id_osiagniecia    DEFAULT     �   ALTER TABLE ONLY public.osiagniecia ALTER COLUMN id_osiagniecia SET DEFAULT nextval('public.osiagniecia_id_osiagniecia_seq'::regclass);
 I   ALTER TABLE public.osiagniecia ALTER COLUMN id_osiagniecia DROP DEFAULT;
       public               postgres    false    227    228    228            �           2604    16411    rangi_uzytkownika id    DEFAULT     |   ALTER TABLE ONLY public.rangi_uzytkownika ALTER COLUMN id SET DEFAULT nextval('public.rangi_uzytkownika_id_seq'::regclass);
 C   ALTER TABLE public.rangi_uzytkownika ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    218    217    218            �           2604    16432    rodzaje_alkoholi id    DEFAULT     z   ALTER TABLE ONLY public.rodzaje_alkoholi ALTER COLUMN id SET DEFAULT nextval('public.rodzaje_alkoholi_id_seq'::regclass);
 B   ALTER TABLE public.rodzaje_alkoholi ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221    222            �           2604    16418    uzytkownicy id    DEFAULT     p   ALTER TABLE ONLY public.uzytkownicy ALTER COLUMN id SET DEFAULT nextval('public.uzytkownicy_id_seq'::regclass);
 =   ALTER TABLE public.uzytkownicy ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219    220            _          0    16436    alkohole 
   TABLE DATA           �   COPY public.alkohole (id, rodzaj_alkoholu, nazwa_alkoholu, opis_alkoholu, zawartosc_procentowa, rok_produkcji, image_url) FROM stdin;
    public               postgres    false    224   <Q       a          0    16467    historia 
   TABLE DATA           X   COPY public.historia (id_uzytkownika, id_alkoholu, data, ilosc_wypitego_ml) FROM stdin;
    public               postgres    false    226   ��       `          0    16449    opinie 
   TABLE DATA           ^   COPY public.opinie (id_alkoholu, id_uzytkownika, znacznik_czasu, ocena, recenzja) FROM stdin;
    public               postgres    false    225   ��       c          0    16484    osiagniecia 
   TABLE DATA           ~   COPY public.osiagniecia (id_osiagniecia, rodzaj_alkoholu, nazwa_osiagniecia, opis_osiagniecia, ilosc_wymagana_ml) FROM stdin;
    public               postgres    false    228   \�       Y          0    16408    rangi_uzytkownika 
   TABLE DATA           6   COPY public.rangi_uzytkownika (id, nazwa) FROM stdin;
    public               postgres    false    218   ��       ]          0    16429    rodzaje_alkoholi 
   TABLE DATA           5   COPY public.rodzaje_alkoholi (id, nazwa) FROM stdin;
    public               postgres    false    222   ��       d          0    16498    ukonczone_osiagniecia 
   TABLE DATA           U   COPY public.ukonczone_osiagniecia (id_osiagniecia, id_uzytkownika, data) FROM stdin;
    public               postgres    false    229   B�       e          0    16513    ulubione 
   TABLE DATA           ?   COPY public.ulubione (id_uzytkownika, id_alkoholu) FROM stdin;
    public               postgres    false    230   ��       [          0    16415    uzytkownicy 
   TABLE DATA           V   COPY public.uzytkownicy (id, ranga, nazwa, haslo, waga, wiek, plec, mail) FROM stdin;
    public               postgres    false    220   �       q           0    0    alkohole_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.alkohole_id_seq', 69, true);
          public               postgres    false    223            r           0    0    osiagniecia_id_osiagniecia_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.osiagniecia_id_osiagniecia_seq', 27, true);
          public               postgres    false    227            s           0    0    rangi_uzytkownika_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.rangi_uzytkownika_id_seq', 3, true);
          public               postgres    false    217            t           0    0    rodzaje_alkoholi_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.rodzaje_alkoholi_id_seq', 11, true);
          public               postgres    false    221            u           0    0    uzytkownicy_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.uzytkownicy_id_seq', 26, true);
          public               postgres    false    219            �           2606    16443    alkohole alkohole_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.alkohole
    ADD CONSTRAINT alkohole_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.alkohole DROP CONSTRAINT alkohole_pkey;
       public                 postgres    false    224            �           2606    16535    historia historia_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.historia
    ADD CONSTRAINT historia_pkey PRIMARY KEY (id_uzytkownika, id_alkoholu, data);
 @   ALTER TABLE ONLY public.historia DROP CONSTRAINT historia_pkey;
       public                 postgres    false    226    226    226            �           2606    16543    opinie opinie_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.opinie
    ADD CONSTRAINT opinie_pkey PRIMARY KEY (id_alkoholu, id_uzytkownika);
 <   ALTER TABLE ONLY public.opinie DROP CONSTRAINT opinie_pkey;
       public                 postgres    false    225    225            �           2606    16492    osiagniecia osiagniecia_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.osiagniecia
    ADD CONSTRAINT osiagniecia_pkey PRIMARY KEY (id_osiagniecia);
 F   ALTER TABLE ONLY public.osiagniecia DROP CONSTRAINT osiagniecia_pkey;
       public                 postgres    false    228            �           2606    16413 (   rangi_uzytkownika rangi_uzytkownika_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.rangi_uzytkownika
    ADD CONSTRAINT rangi_uzytkownika_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.rangi_uzytkownika DROP CONSTRAINT rangi_uzytkownika_pkey;
       public                 postgres    false    218            �           2606    16434 &   rodzaje_alkoholi rodzaje_alkoholi_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.rodzaje_alkoholi
    ADD CONSTRAINT rodzaje_alkoholi_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.rodzaje_alkoholi DROP CONSTRAINT rodzaje_alkoholi_pkey;
       public                 postgres    false    222            �           2606    16502 0   ukonczone_osiagniecia ukonczone_osiagniecia_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.ukonczone_osiagniecia
    ADD CONSTRAINT ukonczone_osiagniecia_pkey PRIMARY KEY (id_osiagniecia, id_uzytkownika);
 Z   ALTER TABLE ONLY public.ukonczone_osiagniecia DROP CONSTRAINT ukonczone_osiagniecia_pkey;
       public                 postgres    false    229    229            �           2606    16517    ulubione ulubione_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.ulubione
    ADD CONSTRAINT ulubione_pkey PRIMARY KEY (id_uzytkownika, id_alkoholu);
 @   ALTER TABLE ONLY public.ulubione DROP CONSTRAINT ulubione_pkey;
       public                 postgres    false    230    230            �           2606    16541    opinie unique_user_alcohol 
   CONSTRAINT     l   ALTER TABLE ONLY public.opinie
    ADD CONSTRAINT unique_user_alcohol UNIQUE (id_uzytkownika, id_alkoholu);
 D   ALTER TABLE ONLY public.opinie DROP CONSTRAINT unique_user_alcohol;
       public                 postgres    false    225    225            �           2606    16422     uzytkownicy uzytkownicy_mail_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_mail_key UNIQUE (mail);
 J   ALTER TABLE ONLY public.uzytkownicy DROP CONSTRAINT uzytkownicy_mail_key;
       public                 postgres    false    220            �           2606    16420    uzytkownicy uzytkownicy_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.uzytkownicy DROP CONSTRAINT uzytkownicy_pkey;
       public                 postgres    false    220            �           2606    16444 &   alkohole alkohole_rodzaj_alkoholu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.alkohole
    ADD CONSTRAINT alkohole_rodzaj_alkoholu_fkey FOREIGN KEY (rodzaj_alkoholu) REFERENCES public.rodzaje_alkoholi(id);
 P   ALTER TABLE ONLY public.alkohole DROP CONSTRAINT alkohole_rodzaj_alkoholu_fkey;
       public               postgres    false    224    222    3501            �           2606    16478 "   historia historia_id_alkoholu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.historia
    ADD CONSTRAINT historia_id_alkoholu_fkey FOREIGN KEY (id_alkoholu) REFERENCES public.alkohole(id);
 L   ALTER TABLE ONLY public.historia DROP CONSTRAINT historia_id_alkoholu_fkey;
       public               postgres    false    226    224    3503            �           2606    16473 %   historia historia_id_uzytkownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.historia
    ADD CONSTRAINT historia_id_uzytkownika_fkey FOREIGN KEY (id_uzytkownika) REFERENCES public.uzytkownicy(id);
 O   ALTER TABLE ONLY public.historia DROP CONSTRAINT historia_id_uzytkownika_fkey;
       public               postgres    false    3499    226    220            �           2606    16457    opinie opinie_id_alkoholu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.opinie
    ADD CONSTRAINT opinie_id_alkoholu_fkey FOREIGN KEY (id_alkoholu) REFERENCES public.alkohole(id);
 H   ALTER TABLE ONLY public.opinie DROP CONSTRAINT opinie_id_alkoholu_fkey;
       public               postgres    false    3503    224    225            �           2606    16462 !   opinie opinie_id_uzytkownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.opinie
    ADD CONSTRAINT opinie_id_uzytkownika_fkey FOREIGN KEY (id_uzytkownika) REFERENCES public.uzytkownicy(id);
 K   ALTER TABLE ONLY public.opinie DROP CONSTRAINT opinie_id_uzytkownika_fkey;
       public               postgres    false    225    3499    220            �           2606    16493 ,   osiagniecia osiagniecia_rodzaj_alkoholu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.osiagniecia
    ADD CONSTRAINT osiagniecia_rodzaj_alkoholu_fkey FOREIGN KEY (rodzaj_alkoholu) REFERENCES public.rodzaje_alkoholi(id);
 V   ALTER TABLE ONLY public.osiagniecia DROP CONSTRAINT osiagniecia_rodzaj_alkoholu_fkey;
       public               postgres    false    3501    228    222            �           2606    16503 ?   ukonczone_osiagniecia ukonczone_osiagniecia_id_osiagniecia_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ukonczone_osiagniecia
    ADD CONSTRAINT ukonczone_osiagniecia_id_osiagniecia_fkey FOREIGN KEY (id_osiagniecia) REFERENCES public.osiagniecia(id_osiagniecia);
 i   ALTER TABLE ONLY public.ukonczone_osiagniecia DROP CONSTRAINT ukonczone_osiagniecia_id_osiagniecia_fkey;
       public               postgres    false    228    3511    229            �           2606    16508 ?   ukonczone_osiagniecia ukonczone_osiagniecia_id_uzytkownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ukonczone_osiagniecia
    ADD CONSTRAINT ukonczone_osiagniecia_id_uzytkownika_fkey FOREIGN KEY (id_uzytkownika) REFERENCES public.uzytkownicy(id);
 i   ALTER TABLE ONLY public.ukonczone_osiagniecia DROP CONSTRAINT ukonczone_osiagniecia_id_uzytkownika_fkey;
       public               postgres    false    3499    229    220            �           2606    16523 "   ulubione ulubione_id_alkoholu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ulubione
    ADD CONSTRAINT ulubione_id_alkoholu_fkey FOREIGN KEY (id_alkoholu) REFERENCES public.alkohole(id);
 L   ALTER TABLE ONLY public.ulubione DROP CONSTRAINT ulubione_id_alkoholu_fkey;
       public               postgres    false    3503    224    230            �           2606    16518 %   ulubione ulubione_id_uzytkownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ulubione
    ADD CONSTRAINT ulubione_id_uzytkownika_fkey FOREIGN KEY (id_uzytkownika) REFERENCES public.uzytkownicy(id);
 O   ALTER TABLE ONLY public.ulubione DROP CONSTRAINT ulubione_id_uzytkownika_fkey;
       public               postgres    false    230    3499    220            �           2606    16423 "   uzytkownicy uzytkownicy_ranga_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_ranga_fkey FOREIGN KEY (ranga) REFERENCES public.rangi_uzytkownika(id);
 L   ALTER TABLE ONLY public.uzytkownicy DROP CONSTRAINT uzytkownicy_ranga_fkey;
       public               postgres    false    220    218    3495            _      x��}Io#W���oh��A4J����ZJ;�$.#BTp������QF��^%�׋�z��]�w��#�K�w�`P�����Dƽ�����3�<���(����EI�|�e�[�A{���R$A�k/��^V�(�6.�;/��0�$�^Eq���\D��]o�� ��B�%����[&eV��ͧ�� L�r+�8���ӏ�GI��޹���C'�W�JzE���S�Sz��H�&�am,�i&S|H$�t�kX,u�i%�M���Sx��^���qz�\�+\x"��F1�N7�?� ���/E��db�"�/w9nS�W��(���w=��X�����g��4_f�v-o����.��{w�s���˚��� ǧ�Ra��>U��v���8$+�I&bm<���N�y�v��q%^&6���ަ�D�N�T�!�����YR���K�W@Ka���s$0�^�D�D���!�C�䔢���Jԧ��������Up:���G�m^���ŧ�����Pkp�@ʫ2�$%,.�`�M�����&l���,�d~��AY���ϰ}�H8,|{⽈b8�>�f�-����g��:���;	?�q�+�p%\�؆���c,�%,ɶي�I�����6G��b���$<"
wpr"ɢ�v����9��k{'� ]�a]��V�ȭLAK�[�P��p%b8��s`@L ����(m@�|X���������K%<����� $z����O?u=y&|"�L72�q�W ׭ƆU�*���:��?Q��G�7 �:L�6rs�/+�������y&��*�(4�$4�|�u���_C�v2��?��kA"�H��
��4��Pj�L*60t�D ߵ�e�>��_�#�>�"]b��3�
K+�~+��4���*r��i���K ҂	����31[�E�S)���X����'��Y%(w8rk�m�%=�r d&� ���A�(7'��l6��NOO;wY�O�k��O�]��RF����_�{��A
�~��J���`4�&�w�Lޟ�����d�_}6���B��2��!�&������oTDZm���2q���3 m��@�O�i!�p M{Y���X�$�����{�h��	_�G1�V�7/��{�X)ı�[� ������+�WvJy�;�>v��2 5V |������2��"�XTS4�L5PrtK�A�&���6%X�C4�yr��cs�]�O��3J��.� Y A�A
��"P���^,DP�@������CYER�fa�UQn�buq%�t��؜�O��������ǯ���\ >`� �a�T& o� /��8A=�Ñ��](0)����/�c����e]�j��$�������Fpnhu�>�}A�4B��x'-wK���7i��I��`�ekcL�3V/d����l�&��x�m�!�b��w��a�R������@[D!�F0	����DAH��x*7�.��#�A�"RY�p��i�F��OڦpS�&@������δ��Ar�]�~��+wK@c�;��B�5�$)c���������d ��L&��`00����ql�����W����Dٓ"\�?�;��3�S��_�2��;��j�H�ɷ��I�5V�8�c
D�W�� c� �l�
�	*���.J7aYGZx����#�Ŧ?�{%;t!x�]*G(Ư�M��3�(��J��WxD(E" d
�Aj�d��&'�GmQ�����u �D,F�� :R�r п]�>BBA��t"�
��[ʕ@����A\c@YiTp|F�Re�Ԇ�9�Up�X/C0$b��eܿCBg��}<_��#vU�&&X�k�P8��N�{���@�U�c��"�� (�c
�u����<M���LD��T"XI�0i�[yQ �:OUzt��
G�՚`�z>׏~ɶ��d��2�-`��'��y�ǃ/d��oCf9=T�Z)H�$�T��&���O@RЏ�>*Ӯ��)*T�E���;��ވV���;����(	�8>�سO�V��^�I��"�#���a�]�y����ؼ"��c��
> �#��+��V�;��mT�[@�D��<��!s8�  8�܃�b4�C��#��w�>�z؏����|0x���Є������p2����.�.����������嫳����ח׽��˛/{��g/{��ϯN�1X���3�,���� �5@��<�NT�F�$JG�����J6���O'�/JfUڙ��p��*#�]��)1߮X�J���D';�6xI��,S�:����=ʂr��Wp�w��$BF�/g7~�?��D��u�XP"u��< ���k��*�}��\�C�>9!W�b%A�x����5[
N�U��`�(`@#Ck� �l��Q!���\DEMm�h�D��_	�݁z�#�14�J�m6��?�#D2k&�&�C�I0#�q<,���4�Xh1m�X���B��������Q	$U�[��'�Z��I��]W�+��}�����8�������ֱ��� �C3�p|8A��h��T	��;�����3���i�M��}����,�$&��-�z�&wy�/�rN:�@͢nh!�Rto nmV�?���b~:�L&'���)����a����	c��Xl����pB�l큤؈�Z��P��36�{6Fxg�@B���]	2y���a 4h�$ �Is��l?L'����C�F�	8B4�h�6>LF
H��`�@푟u⽅݋4u@?)�J��l/�;tEi�O��<U��"��~�*#�:�~�=��C.a��y9I��ŭ�V;&��d��_���?�ׁܲ�l~�k l����胣
F'�[�|E��H�WXؑ��]��E�܂�m�N>�tNÀNd�/t�s�����/ ��Q
|n�S9�:4��5��ȵ��� �Z/KQݏ3�	4e��(RgE����/[��Q��ɣ� �2@�����1���KХ)P�S�oZ�4���ʠ�Ć|eP¤0���؋4W�������z�cE���L0�}�7�	���
�.U7BLI
��
��
�A|=�z��F� �;�L;���8�F@@��l2ꁄ���Ax+�?��SK�-ê*�Ţ7�v[��� ��E�B��
�b���.ѳY�P� ���X&(<���<KB0��o>=%ĳ!kd{#P{�w\�J���6�U|ɱ����Ȋ����ty&�Yi�~w��#o�-��	>�\y+T\��]\T$�#�gT�V��y����%[@�uf�Z��g�&M׺���0��1`�,����h���-��?�Jd� �2�;�����A�����>,��v�[�6rCO�\�}@�RA|_�/9J���=hH��6r�Т7g����r��:�T`��2D7�����5�5�J�愳U��|X���m��-�>a��,Fٳ��7޷���0#����*��9��*�)WT������J�~*E<���j��K�H�������i��\���LNF�u,����pWk���3�d��x2�g�ɬ?���t���o`[��>��O��毹��!�v�g�GD���O1��\ù�? �J�ΕQQ�	7j�p�e�}!�<�я)R�Q���{�Ηh��ϵŌ�����#�߈�v8��T�r:0Ƅ�b��+�P�_@B�ޢ�7I��|̠SJt�r�u�if����5�.�MP��<a�ջg������wX*�����
�c2бj��K�D ߑ���
��ґ��d�'5�}aU@���}�z���o�<����ب�p�p
��[�l �Yz�NEK
��~kJ$�A������wMdJד�^�e�y�`�~�稅Nb����re�����Z&U�8�߂X�y�Ȕ�4G�R��6�\D��GID����
���8�Թ�:KHd���c
�8����´R˰�%�Q0}�h�h�L��    ���N(+^�z��2ԹV�A� 
K�b���H�l�eh�<��\�1����2��D0��φ�p1Ng���p<�?�N��ܾ�o�_��������e���Y���٫��xޛ���Uo8�����d(z.���b8�d%����j
��AL:i&�`c\�B������8T�h\�#m�t�BDC�����	�,^�
�A�8`m��`��Y���
�9�����>�0��{��w(��i���f�u����PJr,� �[rŹ����&�TT��} cg�X� �I'D�i��N41)��K'Y|�X�ث��d_��"�����/�̵�Ӈ=E��>���6��8���q��G$�g���y����Ux�J�I ���h���
 ��Ű�0����t�*��^�f�ɝ8� ��Oʆ"2���W��U��ʍ&����Lm+:�(��ܹ��O���d?�e�X�uh�|mZW�𪺎��1
�GX��>7�&P>�Ig~����I�7� �` ���y{v��������W6p�����y����=@'	0w�7"�������N���A�l- hj���\��_�)�pqʦP�Hzn���O�ϭV��W�DʔL(\F�� +9ֆ����`2�)J3Hc��~��]x_�m����;$�^�p0�'x,~'�8��Ǌe��J�x/T�U�P�xi��-�/(�뚽�j���)��G��je��FB���+ � _�>�x�Tq	�b�tqy�Q��@�נ��8�f��	&���<�R�}���@�������V�p��ꦮkQ	��$B���׻��$JC��f���C�9����6��0~�����ҠO�9P)��57u�^�(�͔t��F�䭌W�4�%F�8�i�U)�K3-Di:�\�U)�D=�
��v��N�Ԣ_�'���� �wr�W����/z�)�xO=u �W�5�M����NOOg��x4�0s��J�Q��a�t_7,2#�X�@�5g/�}�/ m��$��B���pi8?������b>��;���է^�E��2`���UF�rjM��Ė��Tp�-H��N(C*#+�����Xj� T�LE�fEh<��?õ$OP�׀H���)T�JK�&&G1�2Xe��xFG�$�{nʵ��r-L[0���*{[�;��_�,�
���T���\���m�k�)����<eC._����}U���8�*�Ɛ#��mU��x
��Ypu�|����T�ʦ���k��~����;{_�
�RQ]ܐ-&V�l �I�X��f���h0@w�-��#�Z4I���� ]���$&��J��2�ȕ�+�m�������t>뿽��\^���z}s�;�����׽��7�hy]^}{q�.p5��蝽8���m�ig�9����P�|��?h$,~���Y0D��"�²�z�B� �5f������E"8�̭*���
�C��a�ޫ�xƧ���%�B_�Q��%�4��� `��l��k�� ��H�j�u�`��]���_���fލȿ�V1�}/�d+�߄Y�y߆I 1Pd�����w6b�dU��:9���U.i�Ɨ����rܧ]T3��e�c�T��*a��tr���=��Y�c�A����є�	�9An�����Z���UUA��;���I�'JĨGhC���ULO̘1m�&v
�M��L1�si��}�u�NlS�{\�q���V��X��oQh�Y�k�"F5���؟��|S`���N:��	H�`hag�04�1�@��f{;�l���k֛O�mo�Ĺw�L,���p�~4]&�����`��6�l��ƃ�����9ظQ*|��w�ǿ��sgу���H7Zj����*���?e��
5h1`�f�WX"��Ѓ���e�Y�h\�z�nc��|R��j|�S`�]�p��w�2Z�����U�n��h�p8��PR�5��@�_R{����[UaF�_ә�Z�:������5�`�Ì����e潒Q�eA��ԚYY��+`� �t� >Q��N�q���~F��S�F�
�v�t��1�í9��Gd{�d��p�-�6
��]��8�Ȑ�`���wPDk�ӦlԹ��O�ݒ)�j�����P����z�����6�@��1 �� `V����H���Ɇ��B�7���Ӯ����e�-)�����T��Y�r\o#��C$D��v��	dh|����t1��9.9?�;_a:�9��6u��K���&�6m$���?{U�����Lp��!��77gh)b�53�_	ph�UX��}���\���h�K(��Y�+ec�FU�;�Nc���<�/�UłW���c��XO}O�!dv���%����R�����TSe9��5�G�,�{��J�z %����(��	�O����Hu����<�-�o2���З��*��gu��=�������J�rS��>���6Ӏ���ы�9���n8[�[�nŠ��Z�������ܲ��d�%Bi������'���&�
��7�l�4̈́���z!Rkj�Q�i@]�tX�j�sY��W(Ȟ
�4j �t�(|��O�L��G���8=A�Fێ;�X=D���5�t����Яs���#�?���_���{~����ꦇ��W�O�w_^�|}�]o����NyG-<��a�x{>ۃdm0z��w48@Fx�~��j1�`��{�����X�^LGL���0a��J������«R'a�f�&��1��j�b3 �Iە���~��)wB#�[$ î�����-1��(�D�b�H*|�C��E�ڀ4-����:|�~b�QA���������8��zh�iL���^�9��Dy�d���Y�F�#
�&�h����XY%�[2��L���U� ·�=�ȷ�[kX����4ɬ2%���2��4�e�/�>���|���<�z�LMU0�fg�.#]�WiUB�$؄��֓��XC�چ�z�hQ�þ�mh��X7�j�� 6̋�#�h�{ �����/_l�ޝ]}}qݻ�x޻:{vq����̦
�N;��3�B��_C�zhLa(�M3<V�0���ԯE��j����ľI��w��X��9�}Zr�TM�|��t��ņ��lme�A��2�kX�7^��{��m�ǉ9�KI��YFϏYׁ�ut�n&�m�_�qp��=e=u_0u�l�n�R��T�M`%V�Z��,WT:L[}�3�`�R�9�����om��m)��M��w��4�[Ʋ�E6q{�8�m����uN�5j�:'��!��zr�'�L9�c�ُ��N�a���8P(f%��H�D�cFz(*R�Vb�62mz�rX�|XHr��t��N�a8�������ބ�"���?�> r�H��{!e:/]��IlHO��R�N(�gb��;=��I?���R��]���,_0Ѱs�����l�m%OpX��|*�Ʈ�8Q�/O������vx�cR�0���jӆN<�B�Q��m�> �6B�ȋ��0��SR�p酙؛��F�9,���B�H%�!&�5�6��Y{,ZU�Ņ�b��ޫ��]���x{6 N��R�f� W~��ǎ-q�FG���j>x�V�I��Y�<gF�DJ�_�Z�s��fH���O�,�����Ӛ�tV�R�:��N���
BB8mA�
7r$�[Ͱ
����OO'����x�	�˗o^_�[���Ͽ>ӕP`�;��90�����ڛcY�#mMM���;��r-�*Kd-v���ݰ�6��<���o�����R���=���%T�{l�����b�I6�K	2 mI�Q��ۘYc�kSD�,&�5�|j��曈�#��Wbm;�U�����qh��)٥���[~�8��g��C�>�p��q��{��P9�H&@��\e�� 0���A��H	�c��5����nGc����5&�2m�!�&�렼�2��fC #
c٢�Y$�P���A]�o�X��Xv��Ĵ���
�� ]p��(�l,*�Q�e>v�`��h��N��t6���Ť�Ië~O��O[�i"F ��    #���+���`��p 5O�����1��ز���wa��=�S�݆�k�I�T�Jz��F�ح��f6��DY�����P���<���ҶG���\�Xr�1��?6e϶O��R;#�c(U���-�u��?;���E/W��Ǫ�j\Q{F�[����~�F?�{��e�>�n1Pq+e��0���DU�f�Ԛ�UBIӔ]C��F�I�G�5V��K�m�i���>.8���e���"�"�]���A��=����u������62K�HXY�}`�ߠ?�a�ߋ�u�"8ޞ�|6wF�7a|+�A
�Vī����m��#���D�f8<uM��æ����'�� E�`A�ZYW/��J��DT	La����?r{�Le����E�`-/�I���rʬ�FVNZ:sNC�B��9�kti�~�.���5!>���,�Nqc�`�Sĸ�
���)�l�V�Ckr�r4�}��G����0I-Kl�bm9f�1��l ���g�FC��PE*8{�u��#2%��Y� #}X�s<��`�%�F�e0{�q5ԯ��F�-��V��� �Q�+�f�6"GP�Cpz��	{�6"r�N��gQ�b��uD���ٸ1�`���[�Z.& /����y����@����%����s5��X&8�����xH�k.���VX�m��5=�Nk~HY+V�g\���+�v���F7������B�;~Lc�ϑR]�7�E�4�Q�N1��4h9H�09֭ip��FT�Z�k܆](�|m���U�f`�&�2PC`�#wkYLw�l�&W'`�L�b�m=ݠ�?�yՖnR��BumX4"��]�2,&��Q\��ϐk�s�6�ZS���6N��4��`U��wؚ*���mj�侇���=�ҽ�a�E{���2ɳ^�C�u{B�,��θ�b0��P�ج�4�W[��f��-�y�N.�y�zֺ	
�d?7�*7��L#,��X�Ä�b�L��+4�r��ԫ^��E�����8�"����N��Uy8�('^����;�'(�H9.��r (���T��)�oc����Lgz&�4��`�fiC9�Y_�ó��*��z�La�;z ��pk���Ǎp0����'J��nd��I
[ŀy�v~,SK_r�,V�r�x�`w�fŤ3�>\���
U�*L!��<��	������4�Ρ
�:�M]�;)�������"Fh�46L	�<Hw�F��>QJ�.l<ԏV"I��������gП/�:�<�����|jQ��1��B\މ�>G�%�`G?�(�XC�n\&�����%�6�P�i��6;�f��=���-��wps�ck��p�.�]KT����҆��tE��0���_[��ǣ����#
wY�VA��-��3��e3~���p��rw�� z��5s�Q��c�jZ1Ǝc5c�]j���P&��۵A�7�,��@�]�N�}�r7M1 r��T}]b�T��j�5�Q���sՈA�ɍGӜX�d����x��Ň�ĖDn�^a`��7&�i������.z[�4�ݐ��^�M�\����w"&Ұ7���w&��L��Ţ���XsƉ��7�e���&��>:�}�6k}�9K華�����誘	��jL\������p�(ZЪA��;�)�q`���bX��k�d�7/�ʐn�M�up�j�gI���θ9P�Z��{���=SV��I�U�2�`��6p���
���m(ߢ-sj��{zrQ�ђ�϶��sᆛ�<Rm�i�6��9�
��8^:=�N��$f���&4?�/wy�2�	�.��N��=FD��]�=ZLK�PŅ�tr��TL��gd�`��O?}P����a?�m-b29�,�GB���p<_܎o�K3���xo޾��<����wg<�g2�'��3] H�-��L���~�Z6�u��j/�p�MU�$���J����Owy���2jXb�M(�B�ۋPM���A�mx��{�z�a״�
Z��3��ᢖ��,���LƄ	А'Gj������J�� �CG/������f>֍�Ԛ�m�%��O���my�Qpt���mc2`d ��(�`vb�e�ԋkgT�s�F��&�͕غ ڔv4���#���#��w-����c��o���Z}�f�S�O�/�������(K�o)(��b�ǩ�[sG���q0�������C�nϵN8�ԅ-���!Ȟ�[�8߻�V�`=YL�b��e���NO���l|:���NO;��[�{"S�W��!��]���D�JW/8]���W_F�R���;��M�h�*���'��m�
ϬTШ�8(��e�s� MT�ł���_=f�B"�R�,{?A�"��z���kr9U��ø��/vP�Y����������]s��^��?�]n�́���.���A!n��ZJ�X����I�������f<?�����xC��U*u��9M�>G��k�⚵|����=�U�;(y����Ӏ��ŤjWa�+���F�̂��E�;�F�7�k�����Ǭ��?�x�L��`���>��1�b�ʋ�<���
��	\ɓaE��fv�
��g������S�<�P��6�����?՝����h6:>����0��b��~���>6P���;@h66�ivuU8����K�$ ��[,ZO��&����a�U�hLK��G�	�]s�,]�4�@X���AXf+΁�M��?�t�E�G��;@ł]��Z`�pS��	�����lC+��J���W��}��6WUW��6�m*�4"��
L	��cN4�Z��8z�fC���<:��1�Q��x�A?WM�p���Y>}�M�z@�gO]��? J.��U����aA�ꍬ�l��[$ǿG����g_\�����]�~��������z/._�ſ�ag���T�g��B�]Ca5*�'IQ��2�n&p�!����s��>�+�G��m�z	δ ~�-��:!.�ቧ����ʫ���h��6��NUrbs�m�
f1�vD�����&�-�t�!�?��� �o�-�+�ű�r�54.���J�<�#p�#&�����8���u>�M�y8_u�fZ�V��~�me:����:�o�5���p\�S�^}��1Ҧ����!6*�� sݨ���#
R
;Ey|P`����F�&�aN�KW�J��~��Ue��qæH�x+���P�qTY�ߥ�q6�_\��z�{yv�
/a�~�͋}#�3�u6��Z�m?�U�K�?�76�����6�``KB�@�_q
�d祐@m�t�w��e��!�.�(���x
K��5N˹Amx:փ4T���{P`'b�q�E]4\����zU�g'W��FW�lF�NqP��Զ�Cr�6�8P'i�}��C��q��ǆ7\�X
�J�ywe�w��i�zp��Y�Dk�6?ze��w,"~�e[�@D[W�fA\�neiș�P����$����0�%��V	p*6�ġS�l
�"e�3�:��Ӏt��E�gE�}1�����i N���t8�|�X�.E8X�ȵ�Ͼ���w���/..0x=��g��hb��`'�;/q&��B��U�b1��8�j��\�g"Y
��#�_1z�ܨqؘ���ű����#Ň��������@��'���!nmɓ�R�X���hI����?�b�������|���r�]�9�#5�-��4;t�Z����-S���rC=.�Ս��B_ek.E2m�����PO�<��Ǭ��md�-uVIy}}H�����<�^_!B�kn�p��@u�Mv��������3�P����`�I	��h�YE������~�ֆ3����*���c�B���600 ��(�j�b�@?ĸ?���zpT=R3=@�$����|��j�M�	@ח�{��m�t_�]�K�*����o�~Qթ��ug�Φ�~+��f����;(Q6�u�i屺�_�n�)�� �����WMz֤Ϭ�"-��]�\�\w]-7e�����}%ݎ�����>�΢��˂b��Qt�o;�G�z)�i������#�\X��n���Ȓg���-��n]3xc`�)8ϔa�.6���� V  ��w-���n�&	��m����C�M��9JW1F��A��ɬn8����Pm��T�ʣ!�'^�p���S�"Uo����l)q�����b>�y���+0���y�;{u�������͛.f�΢C��s`4�c_����A���eF�����e��h�8��TlY�?X��@��2@|�/;uՄk�����5E�������t��S]�V6� �X� ¹Au���:�@�`�(��i��|��h�Ŏ�>^�VD2�d}��M$��,)gep衮r�,��� H���w^8���wh��ԑc�����'^p�<�m�:9�b��m��E�
�L7�1%a2S�	-�)՗��7�c5:c��z2r �~����̗a0���io:�)k�1\����cx�(��P?�4̧�ka-s��``�"��=ѱjC�N����&�Wr���n��+��T���un�Ip�E�jZ��$~����I"E��e敛��.�ru���o�$�ӑ��NO�4�ܞ���v�[X���O��G���r�I.������&�y
����� ��5Qz)�S@�N'�I��J����|��^����p��g�� ��      a      x�u}[��8��w�*js�D�s-��u\��dtM��JUز	��՟^����R�����j��������i+�o������c������k��l��v~j)|��n���o�/�ۺ��To�l�oOK������۸���no�����>�����4��}l�yl�/ק�
���Q����㍝�����ߺ�F��y��S�7�r���>�?������Sj��yi?m��`���jl|?���C���B}?�����R�;]��;��c;��Ί�wV&G}G(�Rc�~��ƭ��6�wg}G(.�b��(���|Z��z{dl�ow����������BW�;�w�}w�q�k��;-S�3��g�����u��8�m\�(5�˯�u�=��*���]쳞V�~{dl�����ư	w�-j����;���~�e������R�z��P6�B��<�p�������m��)�l<i�}���q/ō�����ư]�FS���Fc�,��hjl��hj���h���l�M���t�O9x���buEk=`V�s����ꈍϽ�`����Zj�������D��_�O��u�8y�l�q��������8[>�2� �ۧ;-u�������zgk�xBl����_����v���ןzj���=�Z�mw�,v+Ι��r�t7!{[?#d�oY8C�
�c��\�w)ܯ�k5<��g�|������	{r��
�^��g�un�����ku�8�ڽ�/�r�8���;�+�����C�6~��!��=?��[4�Fut�5Η��VOᨷ�sB� ����s�-�<�.���{8v~����hQ�`����v�=N�����S0�E��|���?���/��b���jl�z�x�oN�5p�.,_&�ii<Z�����o3N��m���}�� ����,�5twAg�����]nc�{er�(��k��^a���솉�s�g��y�Z�3.���9��m?k�Xi�"��wb���H��A��9�f�p�a�yu��vG�s�g���+��B�5��q�W����k��5�J��3����n����.,w�{�;�[<�7F+���z��Ё��;�~���3���\�C�݃8z�m��v��}}�>)w��Bcb��5�5��̶�~����D��[+�����Gs|?�b���_ޱ�k��ށ��qMx��_'����p���kP�N�`�p�l~fp�џ�1��޵g�C�m��{X�k8�т��9a3C���+���o�jtS�����Ǝ����C�Ƈ��~�5��Z��B#ƀ�Y/�͉�v���ŉ3槷��g.�	'l��˫M������<T����p��nG�.�J�/���w,��>�:����8=�kg8Տ�v-I��iu�kN�g�G~)�|�2������3��v��ܽ�q8����5�38�HZ�����}���`[�Py��NJ{�4=%�ʋ���ǯ�+�XL�u=j:dN�T��PKNK���X|��O.�v�2�GS��Z�m�K|�;[�1Й��:tGH��:��;�v(�2�Bq.�<�/--��n���*��Z�;�m0L�]|�Z�#��;ޡ���:�Y>[����5�pi��)�{w҇���%��`O���:^::o��Rc�cI_bڝ;v�QN�F��]rP;���M!�}j;t��Q4B�w��*q�&�vPi1�\�s���j>�L��ť���� ��X�;%wE�Cډ��-�����xr:����vxc����[�:�91 ?<QN�;O�c�?���?b�k�q�6�ͣ�������U0�q�UFш�*fӸ�>�kc�>xl\����ǆa�Z�r��.\V���A볼6=���5����'�����2,���0����wm��������N��ցA�gf(�nt:X�be�t��g���?�М^��J����Ѱ������=Ì�]����\��Qi�����2�X%���3)��-��̶#���饓Y9c�u2��;߉A��}���v��a��4����ʠ���2i� k��H�N�{wD2�㝮Aϫ�7�t*�)��Dރ�a����n󝥃7�w\a�y*\�{����g���z����ջzڀ5�fd�[zpT���ݩ�L�q�t��TEf�8 ���)�{<���7m�f�zO�S?��0CD���Z��n�­��!��l�����)æD@�'Ǯ~������8v�7ǇT���!g�E�������g[�Ip�����H�n�=������71f���\(�*e�񱓎`��/
s�)�_t|+|�k�p<v:�BX*[�iP7a�;x��[|���x�&	�Z���䕌�GWXP�Dݯ�e�(� ��%�y�pS�t����1��44�<��|qD�Ќ��ރ���-*`�������961>���}�� ؙ�����c�k�kW��mÖ�S���ٜ�Q8t��a�"����Z�ګ?��-L��NTh�w�@�G�UrO��MhB�\^���=x;Q�:�RȩC����p�|��p½���3�HE<z�@�|����7��Ά(�1�׵��o~LM�Ѹ�y��Ԍ��uupf��@�ǩ���+��3Cg{�I���sY[��F��Yn��Т훯�?hL��@(�<4��tk�1���zގ�5dDçZ��=}'jsq�&�2\6��#{x��&`&.������;k�Ϭ�n�5�-�R��~�V8�	#�yT9)��Ϝ�`F����Do�0��a�V���C�v����B���{�S�:�#k\��G���o��{������������g�:3.ws���d��7[V��:�U�����`.��W���5B�fD�P!�豑� �@���_C�2 I���_���~�
�l��aa:pO@�.4~��堫cm�\�b�Cq��C�UkL���{ژ��!����h�m��!�Ջ �},��c���ѹ;�\�������I=�˱-�U<���u�-�Nx��z�+��ޱEc8��N����������5T�)p!8Y�ؑ�U��Ǐ=����l|�y<8��c�c�u���:d��^0�{�.�i�ώ����N�~�C�Jش4�N�m�]�d�p��������	�W��6���wК�m�o�/�	��b<���l�^����0�qݝ����v`}\�/���C1��3{��K:��� q�	0 �͙�^�PAΤ�-��G���􎾗Rg���g��J��݀sž�P��A��p"Y#(���)8d&�!#���ez^F�Kˠ��,���At�.��.'=��HPǟ�:��Y��~�m�o,u���v�Փ4��6 �h�|�=�g6�,�V	J�����v_���� ��rML]c��%R�%�=�e���A��ξ	h������>3�� ����N졆�p���,62Z#(=c��	k: �8�!��bH&e:���%��5��]�۱!r!�γh`�?>v�4�$���!6_\��Fw>�^�8�au�j��0Y<�Nt?�s��� ����9[��p�Nb�(�ۄ#��,�����*���&�w���n�C�,���/_ �oq�M�+�������n�#]E�Z��ٞ���y�V�,���f�lf��aX\۷0�A��Lӓ�Bڵ���ݭ� ������:@韵��un��=���#gc��H !嶆ly�h0h�ye2�q�BC��X�B��%B�+�a�(��sA�
��Z�����z�Ӊ'��9k%�2MZ	~���>��+�<x�o_� �#:Z����{��)dz�U|o�� q�b�VB��rZ�M��q� .P�s4"dޘ5�4e�O��d�,����7��L���T�<��s�M��h2Z35�b�����:�`0�{R^V���a��7fW�>���pa׷%���]î��i�'W��9��C%6�D��o�����������{L���E/�:�8j�,*v�Fkd�);a�t�_��Х5AD����$
�H���    R�P�Z�@k�M��ֶ�Ҩ̊�Dj����;9V��G�G��i��.��Vr��k���1�3k`��u�j`9��<X9\�5��\�4$%jM�;��`c��c����SS�?�k�;� 5��%��߄�8#N�|y�M�Dsȵ��E�.�����A�=�C��!�h�:�L'�����N�����k}B����'��_9��.H,ϸ2�Ш<O �h�{��A�P���Қ�?��g�@[�"ǜ�(�@��$���E�n$=i����{5=��]d��]$vC�%S����	d"ԚJ\���E q�	��+��i{G�+�O��}�:iY5� ��.v ~# 6�Ʊb�@�I'߼�&f��3z��N� �.V{}O�E�h�1�f�x֡3K�t9`��ۙ������:��!���8��w��%ov���8`�3¿�)�03s`�x�8����5.I �0e��kʌ�%u��5�
�KN�
g�$�(��q� k��y�� �qk �`E�o�z�YxH&�"g�b�=y3	Jz��	,�~�y3�Y!9\�����!���i_� Y��d�D@ꪖ�Ó�-������}B�]&vՇ	z���I��	��O��7�_D�{{lu��9��F����N��[ZZ�v��4N�rb���DQ�?C
H�Yc�p�C}���s��,?v��~m��WZ��L���U"h�^L+5ͯ���l,�<�Z��='?D�A���0��0��Ċ)<挣��rK!>�<	"��߆�r�t?�v��ڒ��k�-�����x@�HnqVb:0�BC��#TtA��o�Q��P䤶��8��v����Nm�G:��}n@�����d��m�������ˮ�sN`Q��#F�>�ҫ�E���������0+g���!���9^�<�{�`�`N�s��ϔڎ<ؚ~;�M	"��a0���u@����>�( ����Tl+�����|/��]�>����g�;A }od\\��罏�%Њ�0��[��FK7�/��g�1��"�}�lf�6LX�=�\hI�{� �1����t�z�1+&ת���w��٠�e=�&W�Pv'U�A�� ��
=��̷'N�O��^(�1����U� �y?���x9g�Q�G_Q5����)�o+����,W�0F�ݣ��<z7c�o�9k���9�Ht e.���>��[|�5l���h=nL����k�@�5!"c�aU����k�|o��=��v�N����d8��+�[c�"�'>��j�;΃�̈��7VBN�9��kOKv;6LR��`���R30������3:��$��<ӪR����aN��c���΂�u H�q�~p�V=uM��Q�רbS���c�� ��O�ii|���1}kz�U"��W�����IJt#{&O����E����2���g����020�yI~L�bv�����0��y9�}B�n3m�Id��g$��6K�b�eq�x롻x��׍Qޮ��LGe�#�ԇ\�����5�����_��*�Pݍ��Ti��p���u���E�5�qd�70��^�Be�|�QGkc$r1���<�^E����j$�P0�EƠ#:���r`��G��S�C���lQG,�Pl��)H�\��/�^�L=^B��]Ɯ�"�,lu9�>T`<5_�Qc`|[�L�+Pd��ܙ%�~���Oo|m�Wi�"mr�D�WY'c³�ql^A��X���U} �����V�=�������@5Y���������^$��֭��DOQ��B2�����(�+��g���,R�&s:�k5�W�C:z:�ٕ�J6*D�~�ˑ��~�߰�gr̈[]�
i��'�������)��%)����6P��{٣�J�A���)\+�U.P�q���V��)h�7o]��PeS;#M�R�,J�fq0b�6uP��ǧ���ƣ��j$�:�Ѽ^oL�03B@��c����j�#{a�x���W:}�Ӡ|Č޾g���1�7Ԥa�Ia�7��0�"X��_�md�`5+_6Z��2;G�^}I�^~� �b9_��5��5����h"�֓C.�ߋ}�t� T�W��<-�u��XF�c�vzo{$3XhGg��St������_�5f���U+}��B�M� M� ��5�憌��+��qߏ��PVJ���PC�ъE�X�u�*�O��f�1M��!��a�|х��Xz�0��KtSe�y�kc�2%n���+���CK���=!J��p�rE���-2�X5+��N}c~�ғ��ȾXVu����!5w;��~ը³ee�$I���I��)1���đ�)��~8�t�8~U�8T6T�k\���� �^13���χc��T�p�v��2�I�Q����Itnk��VM8ύeC�1�T$�wnP^��6��8A��.2f�	��g,N|m5W�@!g�'��� �u}�>����M����������{g�K�1��c��y`�i�]9#�;��L�Z�[H��SC�eO)���QYsW�+A�_McEy�j��J�Y9�Fc��O�OY���Gy�I�k�),4�(+�֔,��<bck����P�d����ʉcO���~�!�N�V]�r�ȱ�.Uz������N���/�;a���*x��m������4��ruW�0
�	'A0��;�J�GN��UN],�Փr�D�T�L�IE<�Q���P�6��-��K?�ks࠻���9��E
9W:,���T�bd�����2�;��]e�E�#�J%D�3Z'f���?P!Ǳ0UČa��^[]xF$����`I3�b�%>��4Y���_����vZ��~��6�o�7B�D�N�r�?4Тs��R��Ѭ@�x^6�k��.�;�㞈���t*N"�?����R#j�/[Q�=9ԗ�WA]ĞDj���@�|J�h�G\�x��L4}Od�o�=����t�� �<���@k�k�>bu=E�2yck������\U�.: ������2a̐o�pڷ��|���^=f���YK4V����k=fͪ��@u�ʹ^9b��o=��z!�6Q�U�e��q���lQ4
"�����Ou2�E�g�Aq�;�=�d���ph]+��([��ܟ�PS�nOkNx)эJV��Ҡ ��{Y���՟BD*�#���$i7�G�z#4:ڠ�*+���0F���8O(w��+�Y��)�Lt?j�Fyu��jI�f=�Bx���¤��!�q�N���<��E|'�z��L�h�c��:�B�J�K��"k�U��Qr.P���z�S�!=� �ժW�"\8%̊oU�	0,�U�=V<� �j$��x '%�!�aC��I����9�Hfh��T		r�i�m�h�w4ھ~)� ��5%Ż��E��czh���k�	I�NI����"�:;Q ��d=3g��������7�*J���Bn���2�e� ��S(A��n�'	1r3�
'�y�%%Gb*�IN�����l�*Qƪ:� (_p��"S��O"��0!�J���ڗ'��e�S>��Vc�RZ8��o��\,���b5�)��<6�a}�E�Ǭy)`)�_��z���Sa'gȑ�U�bA�M����JBѣWJU��F��'��ҏ	�F�%���͟�sp3��H;��ƪ�(�(\���e�B\S���tS��"�DH���=i���O�q?w��i/�����@3��V
�	�$Q1\���>����ܡ���XD�%��9$8�Rf�"V��YX@-ӊ6g�V*�e>���(�9$rkY��d������J�����L,�c@Y�/�N�K3q��px��8��(,��EK��rpvoR�g��El��ء�
�?P�%h�w����JI�,!P	��&[�U�����Ƕz�5%���T�J���
��q��&�&��v֊$*� �X����9oe"���Ǟ&{?�Z��Pi))�Ǻ�-�W��c���÷o1s%�I��5�|�0���-�TU�q-��Q8+$4�wb����2
g���O�BZ� ��E}�	`.�;� C��Ak1�*    :A!'���'ӛ���!���uʄT{tą9�έ��j&1*�����u���DA��ў����S�{ma�9XGsA�e�^sB����^zl|�!%�7�H/WKPdV��6Rd�]�wl_���V-����*�Ք��N�*�r6�2�Ф`(:���E���c��*� ���-�p�O��YT�Iמh�~�>m'�*���R��"��3�&�"�'�.�^�L�bNz����(Ҟ=
L�G~;��z2��Ho�I�T�+�o�B]jB#.Z��Űł���-�<q�F\z^)��0��/eP�qb����.����<������LQ�=�T7������c$����E�|D)��ː\��'s�C'�(��1k;�Q�(���|�J\�:���a���G��`E�:R

��9w���+s����i��������D�H%ݫ�L[3��q��BRز,U%�x�4fR�`HP�,G0�GT������ ��gt��0}V/	��ɋm����$ɚ�T�_OV�~�7���o���N�)=N[=��x���E��̄pJӎ�X%K�dF�*ACG�%!����gf1ɎOsI��,N���Eܷ3fW=+HѬ���ꑄ��[T�i<�EQ\mE�m!K�߆���"T�2:�}B�jե�t���W:\��K�0��L5��PT%h�
Ь,fII���"�PVD�� Q�+�������F�>�1E�φ��V�0��8Ԏ	�@~�tKW,�T�8����+�s�8���i	�t`�yrn��x��G�(j���u=��WB�[!�P'\J�
�@}���Ƌ��\��Ċ��R�M�+�d�@�`��Tʌ�x��Wb�/��}�3��P��FX�>�ӫ�`F���QU����3n�GsΜF�)ۣ���W[�	���t�ԕ	ٛ&��U�R
��n20
!��YT�3�K\�Op���u�:��)0e��3��F;Rto ��B�T�WT�L�l�Mu��5UBe��l:u*;E^�:��V �SE��Y�H�E����JC��҃6��=�s�ڱοJ�N��L�R=�V��9'
����nJ�W���A�|�Er�N���I]ΤW��Ҭ��i��W:��0u�z~'Ǉ��Ia֝B	R�L���3v�A���,�~��R]��q�s<��t�����!i��In�[�§Ưp]*h(�A��a8zAU��N�+�/�@�f�k�{3 ��A�Ue��
,:]:3U��~�H��F�tG�P��r��m�ޒ᣺��'�zf)B��e����V�A��������\UyIu�0����?p�v��Eb]b�=�������F�܃���wU=$�#���hG�:Q/���r�śҝ*ta?%P��b]���<�5���QOu����0�s��'��V���Iц��o�JYeh;=�zR�	��y�es�p��rK�|Y�W�d�4z�'Qh�WZ"�B����l�q6�zOL�HR�u��,*"=%���倆����l�I���)*kT�IG�3e���D��˴�AQ�Hw�1X��	�uMR��N*ҭl2���7J�#Y�KZ#��ZԻH8աG�2�M�F�2'Lc�)p�U���VݾIo�c�jNX��^�[$i�!����/vub����DA�R/j�ӱ�x���I�۔�����CkD$��HD2��P���0~����+[��0�!�r(��V
��WE:�$����tV9�(gPy򚄑��s0���`�
S\%-��+�y�J�[���x�	�%��7��Ԙ�x��J���q#�"U�ά��w�������!:�ptV���&AB�p��.�Kx�4�fIZA�>�JL�jr�߮¯�`� Z��D?�F�CL��]��RT(����r1����u�
���5W���.�0��w� uXb��ȹ3'�t�t��e���q~��8�gzG�'�"�^T?�_��
I�Q�{�Hh���d�����A����Pv4,�uo]����D�j�DP /�$2��Ԙb�j�g� �F�Cs���L	AF��U�U�7��\z�D�M)����!{պ�IV��V��T���٩���eὺ�P��=�.t=��e|�=}�'�w�(��P���.�\�l�^��w,��L��j(��IH����Ф���I8����`S8���O)��u�u0��"U]̫��� ���k^Lҩ��5V�s'"5�Qda,]9�3ufi��唦�Ⱥ����'�KˣBqA���g��^5�bU�HE*��J����b^�c#���sB72A�]�V��I� �ӯ����yd�|u�8E����&��DO��Ǔ�;�W�t)�K%�F)�)����m��	��&=����qd�3u�I�#.��
��b���+	Ѹ��,�����9bx[��m�ߦ�yx���I�䉣D,	Yk�	v�@�4*�L�;�j���t�P�9YԚ��@��`]�-!5C'���� N�Kkz�S�"u���B�Q��OȽ���"Y"��P,DAۺ���$��tI�uK����+	U�7��+$mC��$b�+n�3��<�����L}	�.�kI �#�L���c�߻?���j}�*�?���8A��Kx�R4�A.t=��̱�AT*�Xwke��Ew���*OȎ#�~�-_�/�Z�j�/I�'Sߴ$Y���*F����;Es�Q�Ӿ��t#t��{��K�B�e�^wϺW���pU�|MEu	d,�K�%t��[��Y��ӖV��X}ps����W]����:^`���o���� ���{i^�@=\��u1{*�
"[$�*����C���)*��T���* 
7(�[�}� �����R������NO�)
�!(
��S__�HP�{���yk��N{�ݻ�z�w�|Hj�6�1E	w�B����Q�('�뎮4�B����$��\�'�F�j>3O���	��'�rzF9����!}�l��
I�j[B1�l�enOq�H�˒�Tu�U݂<����L�4;��Ӊ����O���dIK�'�����̨퓤Q�_�H����wQ}�+�t�o96~л(�s���heԨo��	j��H����E���G{OGWրR�4f���2Dn���J�ж��ѠA�wH+x�48��H�]�WI&(�.����gU��pg����{�\��Q���4?W���\�$f�⚒���[�tHa%�AtW07�2�HJϽ���x�#�o���d���ʣT�^��:F�t6�DL_Q;C����G�A�;�ȅ4�F�j�W&�C�,�"JL�)Ң~�j�$��t��J�w6�_DW����J�t���
���B�����p����4�Y�+0�̷����S�w�M���֩�n�������Q��a����eQ�[�m��Q	��P���P��/��\�Ģ�o��*?�0zU��q�&���\p���]:I
ظ�ȇn�z�Q31�g������/��7�-E��t����������3�7Ր<T��񣋚�I�$9tuC�Q�������8�Ob�2\�j۫��9�x�|q��D���W��j��Hz�!�	�P�[�r)�^��#y���Go a3��H�Hy�$�z�ˈHr�#o���=G䧬$o������r��T��J�+�k">�d3&������������8TЁP�B����]��e5<>�W���#*M8�KR���Y�(O�Bynˊ�OAs'M��
"�G���\#^^���u;�߻j�ϝOQ?az>���d6����nq#��Q�L��Z�����r>GV�xn�Q����l~ݥDK�s�\�����B*��A�k��#�Aq�O���M�������28/��}]3�yGJ�Ԡ���k����/OY$}P`�Տ҄��a,>�y��9���������X��&�^�sj���0�LP!�i��?^�3\�#U���%���DЎ�\�B�2�Vk�9X.=:3�T#�9E�F�b�"�Qp��O;J��+oQ@I�HJv�:A�^����	��.X����1h$l��Q݄Q��CTx���>�t�&�~�fΟ�rPQs�V	�N"���&�=& �  g7V��A�m�>ŕ~�5B h=���׺��LEΙ钌b:�%t�I��e*>�Hҋ0�}�Id���u�E�8&�邪$qu�;o�ª5�A��u�J�uѢ?c
��
&��j]�m� �g�q��:��7R7�4i�D�]פ ����_�ۛnYi��[�.�-��:e�E���t�����|/������-���*&�����gVQ��R�eb;Z*	&i�F6��pA�G���'�zU�����n״.�W�N�xt]%J�3 Q��ې(c�y�M��9�;�Ϩ���ߺb�dDU9v,��ꢋ����������,�1�JZEW�WȎ���<�җ]���I�ʄ(F�\�x#wg����Mx��1b�ܜ�\�A�Ӷ�s���O�+�rI'�N�	I�B��,u(ɛ4}P��r)���,s0�#����'�t��I�%�"�*�U5E��Q��&�H���Vzۢ3ؗ����:u����H]d�x�$���\�|�p���
IM���6���H*$�̌��B\�"��L�ךW��3���#�g�Bv�8��jl-�x�D`us�+z촉(l
֓VF��EL˺�,�{�7~�R��B>O�!���4+�.w�d�͟���w���/��F�_��׃]Ƶ��פn��*/g��m��(Nxo��5��ܡn�"�Wz�Ȗt�(�ZMrI����������`���l���ϵ�C��Ň��ٞrx�=)�<�R#��'Vө��iY������ϟ��-i      `      x��[͎�H�>��"}�S�P*����u�{�5�h�%E�U)J��?#��1Ƙg��c��Q7��k���d&)fٷvEt�r)#�?���������b����gsq~���w2?��s�U��b��S����$��E'vm)����Fl�j#3�6�X~����L�1Ur�?L�Y-Wk={r9Ǒ!�sK���,Ӯ��/JKL����"�{�":)ҲXj���ȥ�v���3�T������x�V+�Ri����4+%����k%vb#�Z��׃k\���Թ�Y�i���5.���N��Zm���09o۪��S����Y���\nK�Kq�]��tY1�gz���%��H�h��]��6��dU���b[v�V��Ob�I�˦����P�AH�"�2��̀�U/�_S��i��,�BT���o�fP������<%-��75$�(j�Y�>|>�]���(hbS,����������$.r��&�U�O*�,6�x�-������1�,jsG�¿�E�>��-�`t��%X��/)�X�?i�!Q�.�Ӯ��Wn4S�ɟ���NnĒ�@+�OͺY�"����<�8�bc��V��m���X�Dn��i�:���tc�N����T�����3|�*܁٘����+�B��������6ϼ>@�y w[��;iD*�b]��[j���<��gQp�D:�)v0G���(ۙ��Tv$��S�3�n��Yq�m��7,`k��.���ܩ3�'(˰�s��];�u�r�����ת���W�QXp�QeI��ю�� ��|8*1�.����c��W陶N�����eK�!W�V
�am��PCy%)���t���o+g��;����J�Jg��'�@VdJ��DKp�t*+�A�����؊��}�A��)|�
}���4�������bF���K?Uׅ�K�R}Te�r���&��Ֆb��� ����9�	o	|����S�n��Q�3ӊi�\Z�ܢ���U�t��X@�e�M2b�|?+Sۤw���0��,o�_�yQ�!S�;�w��8�i�����i�Mǝ�\Z��1�m֡2����i/jl�����C��Y'Ô�m]�6����}�� eN�����{JI��:2�6��ƽ�cN���g�s�!�����zx8ey6玄P�ۑ5���_�-�p,�ٓ���7���k�/YB�I����eQ ����2�(�j�!n�sB(ܑ���9$��>��	.!(����w��j��k��d�2�b.�dpq_nٛ�R�06���pI��U��,�+]�֖
�Ta��+N}�'�_l�\�0T����H�TDU�����G�f��r�B&����j���o4EO�S���P���f���0�>�x��vR�NKE&ә�� �a+a�������� ��Q,��V���?m���1h���I�ZT�*�ڝ�F	1�R�,H`�\𵝜�5��W�,F"�δ��S���5�6��R9:O�����g����A��h��n����j۟��/H�"k��'�{oѣ�����U�J,ܾ�;7���jpQi��a��/8{���;0� t9"t�٠ZSi�z-OM-##��%�ǵ�r�*���G��:�D�����2'�][!��}3���߯L��L���5�[Y#���^�U��ƛ8�Ȕ{��sePr1�ײ\�R���:��{˄�N�79Jڛ��ܡS����Aѫ�_����M���r(�����DT��mAϭ�&���1u�� x�Va͜i��B5M^�
Ƀb�-?��3!2�YDg�8�g#��{5r��1�����#fp�bX�AU5'�P4=��KD�A�C��@3�i��KČ�X�����U�@����~�K�T׮�~՗YteE��T�9!5W>LM��W�-��u�yA�N�F��Z��Z�<A�O����h�G_�NCs������+"(�ڢY��e0	\���r�f�P�D�%�MF#�W� μk�	 �֌�)�TF�l��*KT�aΙ��{E��OL���,�Z�aB��j5�;���`�}�:3�����m�O�;%F�L�\QLm=?}	j*�����Q�p5q5�
�w�T�KF+�C-�l8F$$�7Zup]b~BH�
���먝��W�	q8^2�Y�r�au5�2S/�;Y���˘�M[	�/e9)��g��t��f�I0o6p�8�`<���C�3
���K�I�v�̪sIn��y���m4��[I a�ل��j�<�������I ��x�Ɨ+�놻� �.ն��Z�F������NW�jٙ)�Y���M.�`s9a`Y\����,��Dh�����R��v��6!�*�L�FQ��j:Ȩ�UY&�󈹼�I&n	�^3ڞ�e�fV�}/S��#l�֣S&����.5���odȚ[���^����)����L4F�|�`�bT:N%'�����A��{*��zEל�Ӏ���7Q�zU��t���Pƃ۪�,�����r<�.ۛ+�fS玳�F+��b�0�y��ʱ	��L0u��~�f:oP�J�1E���;b����/_���\Z:$�!�Hz[��59d�!�z��� �P9Kq�c*�1VD'wzru� g�9<&�[7��lF�iTJ1��+
��0}�-UY0x¾��*��B�%Q�x4�l����B>š�-{	 �
�J
/�f�\&n��>�8h�U��n����v��X�T;sJ�^�b&dFB���0���K����4Pa�6��(3�.~*�U	3A�Y�fjF3�C��zM�q���-��:�1����8�0u-�I+������0������R� ���SへC�GݪEU�gP{a{&��H�:����?8��z�_�����{�&�g����I���k�'��&�� ��$�tG_D�QW���t���e���� ��	��t���s~��J*��e�g	,�14�U�bkt�U�!yl�уL8�/�C�H!�˦ўS�2����������~l!��d��6���_T<����56����nl?}mڃƧ.�ʳp?jY���_��|۬eIF?1����c �;�B�]�M��'��.���i�\�H����u����q�e=:�"��;�CR��h>�(���%����=|����\�s��Y��)��Rf5�S�u�͚�����'SC�(���눿���E�XŴb��a�n )��A{���'��wM�5��+s�G�9��vö����������7G��d6�'O}�o���x8��s�GL���V]��\��� 4���?@�|J�҈�lL�qV��h�П���/��K�|��x��PkB0�jV�@D1��j"��{)P��ha�96v���ņg�n+�/yθf��_=��s����`Wb>����A�:�����O��V}��Nc[$�0>8�X:P�S[�Z�uP�m:.����	�U���c��+S�Q;��� �O/�*���j���{&�X,GO�c�ͫ��L���7�x��=Fh�m����=��ڀ��<�7��/|Z��٧�qVM��+vEB�^Z *.� R�(���j��x^nӴ���r����-���5���ok���-��=�iۘ#]+���N�ތ]~dH�-hz"˪�Q�m�7��WmnP3��a�>Ք��ps*��_���t�B�M�������_���Ժ��͊m��R2�&x Ԕmhj�Ss� ����nl���F���岕'eշ)��kp���j8�q�[��a�t�ֲ��뛙�;҈r*�+v���d>F�|8�u�La�����Z_���6�B뷼���#�#h��Y)��R��n>F�烈���<iu�0��G��	������E����O*>�@#�K��B���x�E?���-���2�K�J�B�K��B��>���+'���0�����5
Z�i�Ƚ)��� �A/�{��=w�Hy	>Y�h��K��'SxL���̡�Ų,6�(*&��8)DV����<��,�!8��NgQ�Pp���aY�� �  YH�O�9�Z 4�����M&�,R��'*`T��̠��Q �:$�:�&��Inm�M��D���	�\��1zbt��?���GT��s�݃�]a�k�V"r�El�nk
�쌖�k���~�����	qT;�{�~b
j�=��	��,e��N�*���;��lq6����+���qy��z��Cu�42@� *ݱ���7	A
��%^�Wh�V��h�@|�n-�������駈�e��
uТ�G��/@h�`��w��t��﫟��$J�g��̥�����wl��6��
�XT����t=^���[��'�r�C<��Z�5�e��\�W��b�2R�Z28�[j�ػ�SfT��tk�L4�S㭼�!�eyh��P��KG��Ǯ5�X`�(�ߣT����ƽ�,eW�of���A?b����v(��w_��v�����kC�/G:�Т�k���S��l6R�U!׆�͢��}3�Esϼ�������Z�%����.�?�lV��-�;��<��oi{��`��`=�-���}7�#\�� yh����j)���Ԙ�O�������� ���9|���� MӋ�M��#�8<�y���+!?�@�.�y��zPΆRsK����Cm�\%�h\��R��bGr�/\G��̸u+�v6N�'s�%bq���VR����m����a��i����Y���^����QҷO�NV�e��G;	P�����ūf���5)xs @\��`S����9ُ]�m��	�O������:�"�yAS$m]6��2�����n�&��)!m8d&��!3}*����޴��K�s�?�w�&�6m2�S�x��:�.HY����$��z�8�9;���fa�W��Y8�k����}[84���{��wĘ��5�ʷ_���M	�V4Ȍ5��g:�!ˮ]�M>V����&�0܀1wP�xm�N�E�I�;Pi��9z�Đ��60�������_x/.���/������������Bԓ���L�~��aP��Y�u� ��.���ُd���o�.a�'��9>����������8>�����s|���9>�����s|���9>���7�4�	�yxFÝ�Տ�7���˳���;�igO�{��ɓ�	��v      c   :  x����n�0�g�)8�K Q��jt�]iAV&�d�՟��X �C�1�v��^��T�2d$����tw��<�6auyɢ|y	K��¤۔G�s���#���(X������,4�xp|�BK�T�Jo����'��L�`�F�T%|�%x�`�:r�Z�$lX����)�d�F�W�fI5��XR���
?h[��Ҩlm-h��י#�Nd���(y�	�7�Q�;�_�:�$kP��xt<�M�ٜOۨI�O�`syj,$yf�6���A��`R�5����kԔ��<��.�}r>ţζ���Y�>�6؂O�;��� �3��5���:�#� I[�#�w��h��)���4*k�$���J��3ė��",����&C��s�Iy�;��a���y�،=䇷{��:�p;t�����4�y�H����y4S��.B�9��~�C0õ(���	v��c��J��hYj����fmi1��B�����S1�2�7Gfg��<�������e��	n��c�?4oRL��G�a�F�ҽg�NO�z�ȳ޲���=�#)��[�q^;��      Y   0   x�3��M��/��2�tIM/-.I,�/�2�tL����,.)�c���� B�      ]   L   x�3��,��2�����2���,ή�2�?�9%;�˔�=3�ˌ�'3;3��˜3�4�˂3$��43'�+F��� ��$      d   t   x�e�Q
� D�o��h�K���
Z2�<��Ѡ��5��rVzeTf�ܕ����u
��$��{��v�=�v���N��(�)�>��������	�!)�y�����_X%      e   7   x���  �7)�q �b�u>����A�-XC"-J����������{���H,	�      [   �  x��W�R[Y\_��n�qΩ���e���<�6Q�B/Z ������yVwV���
UVUfVJ6��4�q���}u���ߥ�>��7q@˧CqN�Vw���� �0B��s\���/.E%��&s�X�geM���1m+%��l���{�?.�?V=~?�x|��*J�����l��>0�!Y��Ʋ���dd"务���J-�q.�׼�R4Z5�&�w(�ƓE.�|��K�]� ����8e�����K%m�R�%/���\%%
J$*�I%6_F6R����`Qs��,{PDu�.���e4)���n)I+�g�t� De��V�S)^v>Š�oB�5xb]8y�Z4�� 1�l���F5�g��{�̇��Q�M�ass1�����b�:���tZ��*I���C*&�}/�`9�B�����0i0��m���|O֋����ts�0b�����A��X��Ja��zw�p16K�n��ؼ�Yi�H���F�(t���&�7z��l�����C�D6s7ӷ��q����L]��]U�C2��q�,��
2bW:� E�9����t����(���f��C���LǓ>�@x_ϯ����c3����>z��(���V[i��k]�aا@��G	2��E��M�J��K�y`�]�$�O�1Ǘ���h~�o�>m#���]L�R5�	І�#	�>�ʥdՍE�
J��Ĕo��` O�eA4܇;�f���ݜ�D.4%+���`�.ۚ*K��&�*%�Q�l����"�IDW靦���B,�0�٘�=d��^��ix}>�%{�Q(v2&�1��Q>V�yҡF������l�Bn<�-$�m��%�L~C�o�s0ew8:7]��뾵�r��z=�|�Nc5�mu��*Xx$Do�40/�����T��!Z���e�b��2����=��C��ʆc�}y>�������|W�M�*��3Ó�/5� �ɰ�Q��q஬�8��Tcvﴎ�eئ�^�m��Ţ�)�j��������/�v�-��v�5o�/���¬kp�;{ѩ�d���xއ���m�dGQ�������|~�|P����*xg��B�HY����ڂ���T��Hف ���n06��S����?}���~)������� >���`u�
�`ʘZ��E��GmQҩX+	��Y�0&l��Hk�D';�Ma:E՝@�C�QY�e%f_�ͫ2h�\���,j20Ei"n�3x��@F�D���p�e��KF2����r�\[�ZwUw0�+��h�Ou�I�-C�c$/B��t�ZG1�;gŲw*���d��h�V%s.��#�^�p�hc��O�c����^�Ky^-/�./g┠�D��T�-���@2O���@�M�$�E#�����4��L���D�N�	��ˆg���!-f{���ո��r�G�����g�4/۠�5��r;�J��ST���CU!e��z�=�AѤЋ�Q��7�tC*�����}�7$�q���T�Ưw���vr�w|��"�)g��IDQA�-�Y1��UՐ��l��K�F&��X-j�[x{��D7��f���Ɣ�@�ӣ�����G�N�G��Ѧ��DJ;��@��/�_���<D%�%%ɀ�R
0VP�A,�a;�t���>Ŝ �����r�8=iEGJcDR�P�Y"�Q��%נj,���?�n,6 �֎2@������^��{{{�p�     