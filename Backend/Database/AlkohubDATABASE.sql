PGDMP                       }           AlkoHubb    17.2    17.2 @    t           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            u           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            v           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            w           1262    32929    AlkoHubb    DATABASE     }   CREATE DATABASE "AlkoHubb" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Polish_Poland.1250';
    DROP DATABASE "AlkoHubb";
                     postgres    false            �            1259    32930    alkohole    TABLE       CREATE TABLE public.alkohole (
    id integer NOT NULL,
    rodzaj_alkoholu integer,
    nazwa_alkoholu character varying(30) NOT NULL,
    opis_alkoholu text,
    zawartosc_procentowa double precision,
    rok_produkcji integer,
    image_url character varying(255)
);
    DROP TABLE public.alkohole;
       public         heap r       postgres    false            �            1259    32935    alkohole_id_seq    SEQUENCE     �   CREATE SEQUENCE public.alkohole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.alkohole_id_seq;
       public               postgres    false    217            x           0    0    alkohole_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.alkohole_id_seq OWNED BY public.alkohole.id;
          public               postgres    false    218            �            1259    32936    historia    TABLE     
  CREATE TABLE public.historia (
    id_uzytkownika integer NOT NULL,
    id_alkoholu integer NOT NULL,
    data timestamp(0) without time zone NOT NULL,
    ilosc_wypitego_ml integer,
    CONSTRAINT historia_ilosc_wypitego_ml_check CHECK ((ilosc_wypitego_ml > 0))
);
    DROP TABLE public.historia;
       public         heap r       postgres    false            �            1259    32940    opinie    TABLE       CREATE TABLE public.opinie (
    id_alkoholu integer NOT NULL,
    id_uzytkownika integer NOT NULL,
    znacznik_czasu timestamp without time zone NOT NULL,
    ocena integer,
    recenzja text,
    CONSTRAINT opinie_ocena_check CHECK (((ocena >= 1) AND (ocena <= 5)))
);
    DROP TABLE public.opinie;
       public         heap r       postgres    false            �            1259    32946    osiagniecia    TABLE     *  CREATE TABLE public.osiagniecia (
    id_osiagniecia integer NOT NULL,
    rodzaj_alkoholu integer,
    nazwa_osiagniecia character varying(30) NOT NULL,
    opis_osiagniecia text,
    ilosc_wymagana_ml integer,
    CONSTRAINT osiagniecia_ilosc_wymagana_ml_check CHECK ((ilosc_wymagana_ml > 0))
);
    DROP TABLE public.osiagniecia;
       public         heap r       postgres    false            �            1259    32952    osiagniecia_id_osiagniecia_seq    SEQUENCE     �   CREATE SEQUENCE public.osiagniecia_id_osiagniecia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.osiagniecia_id_osiagniecia_seq;
       public               postgres    false    221            y           0    0    osiagniecia_id_osiagniecia_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.osiagniecia_id_osiagniecia_seq OWNED BY public.osiagniecia.id_osiagniecia;
          public               postgres    false    222            �            1259    32953    rangi_uzytkownika    TABLE     m   CREATE TABLE public.rangi_uzytkownika (
    id integer NOT NULL,
    nazwa character varying(15) NOT NULL
);
 %   DROP TABLE public.rangi_uzytkownika;
       public         heap r       postgres    false            �            1259    32956    rangi_uzytkownika_id_seq    SEQUENCE     �   CREATE SEQUENCE public.rangi_uzytkownika_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.rangi_uzytkownika_id_seq;
       public               postgres    false    223            z           0    0    rangi_uzytkownika_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.rangi_uzytkownika_id_seq OWNED BY public.rangi_uzytkownika.id;
          public               postgres    false    224            �            1259    32957    rodzaje_alkoholi    TABLE     l   CREATE TABLE public.rodzaje_alkoholi (
    id integer NOT NULL,
    nazwa character varying(15) NOT NULL
);
 $   DROP TABLE public.rodzaje_alkoholi;
       public         heap r       postgres    false            �            1259    32960    rodzaje_alkoholi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.rodzaje_alkoholi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.rodzaje_alkoholi_id_seq;
       public               postgres    false    225            {           0    0    rodzaje_alkoholi_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.rodzaje_alkoholi_id_seq OWNED BY public.rodzaje_alkoholi.id;
          public               postgres    false    226            �            1259    32961    ukonczone_osiagniecia    TABLE     �   CREATE TABLE public.ukonczone_osiagniecia (
    id_osiagniecia integer NOT NULL,
    id_uzytkownika integer NOT NULL,
    data date
);
 )   DROP TABLE public.ukonczone_osiagniecia;
       public         heap r       postgres    false            �            1259    32964    ulubione    TABLE     h   CREATE TABLE public.ulubione (
    id_uzytkownika integer NOT NULL,
    id_alkoholu integer NOT NULL
);
    DROP TABLE public.ulubione;
       public         heap r       postgres    false            �            1259    32967    uzytkownicy    TABLE       CREATE TABLE public.uzytkownicy (
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
       public         heap r       postgres    false            �            1259    32970    uzytkownicy_id_seq    SEQUENCE     �   CREATE SEQUENCE public.uzytkownicy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.uzytkownicy_id_seq;
       public               postgres    false    229            |           0    0    uzytkownicy_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.uzytkownicy_id_seq OWNED BY public.uzytkownicy.id;
          public               postgres    false    230            �           2604    32971    alkohole id    DEFAULT     j   ALTER TABLE ONLY public.alkohole ALTER COLUMN id SET DEFAULT nextval('public.alkohole_id_seq'::regclass);
 :   ALTER TABLE public.alkohole ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    218    217            �           2604    32972    osiagniecia id_osiagniecia    DEFAULT     �   ALTER TABLE ONLY public.osiagniecia ALTER COLUMN id_osiagniecia SET DEFAULT nextval('public.osiagniecia_id_osiagniecia_seq'::regclass);
 I   ALTER TABLE public.osiagniecia ALTER COLUMN id_osiagniecia DROP DEFAULT;
       public               postgres    false    222    221            �           2604    32973    rangi_uzytkownika id    DEFAULT     |   ALTER TABLE ONLY public.rangi_uzytkownika ALTER COLUMN id SET DEFAULT nextval('public.rangi_uzytkownika_id_seq'::regclass);
 C   ALTER TABLE public.rangi_uzytkownika ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223            �           2604    32974    rodzaje_alkoholi id    DEFAULT     z   ALTER TABLE ONLY public.rodzaje_alkoholi ALTER COLUMN id SET DEFAULT nextval('public.rodzaje_alkoholi_id_seq'::regclass);
 B   ALTER TABLE public.rodzaje_alkoholi ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    225            �           2604    32975    uzytkownicy id    DEFAULT     p   ALTER TABLE ONLY public.uzytkownicy ALTER COLUMN id SET DEFAULT nextval('public.uzytkownicy_id_seq'::regclass);
 =   ALTER TABLE public.uzytkownicy ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    230    229            d          0    32930    alkohole 
   TABLE DATA           �   COPY public.alkohole (id, rodzaj_alkoholu, nazwa_alkoholu, opis_alkoholu, zawartosc_procentowa, rok_produkcji, image_url) FROM stdin;
    public               postgres    false    217   -Q       f          0    32936    historia 
   TABLE DATA           X   COPY public.historia (id_uzytkownika, id_alkoholu, data, ilosc_wypitego_ml) FROM stdin;
    public               postgres    false    219   ��       g          0    32940    opinie 
   TABLE DATA           ^   COPY public.opinie (id_alkoholu, id_uzytkownika, znacznik_czasu, ocena, recenzja) FROM stdin;
    public               postgres    false    220   	�       h          0    32946    osiagniecia 
   TABLE DATA           ~   COPY public.osiagniecia (id_osiagniecia, rodzaj_alkoholu, nazwa_osiagniecia, opis_osiagniecia, ilosc_wymagana_ml) FROM stdin;
    public               postgres    false    221   �       j          0    32953    rangi_uzytkownika 
   TABLE DATA           6   COPY public.rangi_uzytkownika (id, nazwa) FROM stdin;
    public               postgres    false    223   ;�       l          0    32957    rodzaje_alkoholi 
   TABLE DATA           5   COPY public.rodzaje_alkoholi (id, nazwa) FROM stdin;
    public               postgres    false    225   {�       n          0    32961    ukonczone_osiagniecia 
   TABLE DATA           U   COPY public.ukonczone_osiagniecia (id_osiagniecia, id_uzytkownika, data) FROM stdin;
    public               postgres    false    227   י       o          0    32964    ulubione 
   TABLE DATA           ?   COPY public.ulubione (id_uzytkownika, id_alkoholu) FROM stdin;
    public               postgres    false    228   �       p          0    32967    uzytkownicy 
   TABLE DATA           V   COPY public.uzytkownicy (id, ranga, nazwa, haslo, waga, wiek, plec, mail) FROM stdin;
    public               postgres    false    229   S�       }           0    0    alkohole_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.alkohole_id_seq', 69, true);
          public               postgres    false    218            ~           0    0    osiagniecia_id_osiagniecia_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.osiagniecia_id_osiagniecia_seq', 27, true);
          public               postgres    false    222                       0    0    rangi_uzytkownika_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.rangi_uzytkownika_id_seq', 3, true);
          public               postgres    false    224            �           0    0    rodzaje_alkoholi_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.rodzaje_alkoholi_id_seq', 11, true);
          public               postgres    false    226            �           0    0    uzytkownicy_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.uzytkownicy_id_seq', 10, true);
          public               postgres    false    230            �           2606    32977    alkohole alkohole_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.alkohole
    ADD CONSTRAINT alkohole_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.alkohole DROP CONSTRAINT alkohole_pkey;
       public                 postgres    false    217            �           2606    32979    historia historia_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.historia
    ADD CONSTRAINT historia_pkey PRIMARY KEY (id_uzytkownika, id_alkoholu, data);
 @   ALTER TABLE ONLY public.historia DROP CONSTRAINT historia_pkey;
       public                 postgres    false    219    219    219            �           2606    32981    opinie opinie_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.opinie
    ADD CONSTRAINT opinie_pkey PRIMARY KEY (id_alkoholu, id_uzytkownika);
 <   ALTER TABLE ONLY public.opinie DROP CONSTRAINT opinie_pkey;
       public                 postgres    false    220    220            �           2606    32983    osiagniecia osiagniecia_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.osiagniecia
    ADD CONSTRAINT osiagniecia_pkey PRIMARY KEY (id_osiagniecia);
 F   ALTER TABLE ONLY public.osiagniecia DROP CONSTRAINT osiagniecia_pkey;
       public                 postgres    false    221            �           2606    32985 (   rangi_uzytkownika rangi_uzytkownika_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.rangi_uzytkownika
    ADD CONSTRAINT rangi_uzytkownika_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.rangi_uzytkownika DROP CONSTRAINT rangi_uzytkownika_pkey;
       public                 postgres    false    223            �           2606    32987 &   rodzaje_alkoholi rodzaje_alkoholi_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.rodzaje_alkoholi
    ADD CONSTRAINT rodzaje_alkoholi_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.rodzaje_alkoholi DROP CONSTRAINT rodzaje_alkoholi_pkey;
       public                 postgres    false    225            �           2606    32989 0   ukonczone_osiagniecia ukonczone_osiagniecia_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.ukonczone_osiagniecia
    ADD CONSTRAINT ukonczone_osiagniecia_pkey PRIMARY KEY (id_osiagniecia, id_uzytkownika);
 Z   ALTER TABLE ONLY public.ukonczone_osiagniecia DROP CONSTRAINT ukonczone_osiagniecia_pkey;
       public                 postgres    false    227    227            �           2606    32991    ulubione ulubione_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.ulubione
    ADD CONSTRAINT ulubione_pkey PRIMARY KEY (id_uzytkownika, id_alkoholu);
 @   ALTER TABLE ONLY public.ulubione DROP CONSTRAINT ulubione_pkey;
       public                 postgres    false    228    228            �           2606    32993    opinie unique_user_alcohol 
   CONSTRAINT     l   ALTER TABLE ONLY public.opinie
    ADD CONSTRAINT unique_user_alcohol UNIQUE (id_uzytkownika, id_alkoholu);
 D   ALTER TABLE ONLY public.opinie DROP CONSTRAINT unique_user_alcohol;
       public                 postgres    false    220    220            �           2606    32995     uzytkownicy uzytkownicy_mail_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_mail_key UNIQUE (mail);
 J   ALTER TABLE ONLY public.uzytkownicy DROP CONSTRAINT uzytkownicy_mail_key;
       public                 postgres    false    229            �           2606    32997    uzytkownicy uzytkownicy_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.uzytkownicy DROP CONSTRAINT uzytkownicy_pkey;
       public                 postgres    false    229            �           2606    32998 &   alkohole alkohole_rodzaj_alkoholu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.alkohole
    ADD CONSTRAINT alkohole_rodzaj_alkoholu_fkey FOREIGN KEY (rodzaj_alkoholu) REFERENCES public.rodzaje_alkoholi(id);
 P   ALTER TABLE ONLY public.alkohole DROP CONSTRAINT alkohole_rodzaj_alkoholu_fkey;
       public               postgres    false    217    225    4799            �           2606    33003 "   historia historia_id_alkoholu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.historia
    ADD CONSTRAINT historia_id_alkoholu_fkey FOREIGN KEY (id_alkoholu) REFERENCES public.alkohole(id);
 L   ALTER TABLE ONLY public.historia DROP CONSTRAINT historia_id_alkoholu_fkey;
       public               postgres    false    217    4787    219            �           2606    33008 %   historia historia_id_uzytkownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.historia
    ADD CONSTRAINT historia_id_uzytkownika_fkey FOREIGN KEY (id_uzytkownika) REFERENCES public.uzytkownicy(id);
 O   ALTER TABLE ONLY public.historia DROP CONSTRAINT historia_id_uzytkownika_fkey;
       public               postgres    false    219    229    4807            �           2606    33013    opinie opinie_id_alkoholu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.opinie
    ADD CONSTRAINT opinie_id_alkoholu_fkey FOREIGN KEY (id_alkoholu) REFERENCES public.alkohole(id);
 H   ALTER TABLE ONLY public.opinie DROP CONSTRAINT opinie_id_alkoholu_fkey;
       public               postgres    false    217    4787    220            �           2606    33018 !   opinie opinie_id_uzytkownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.opinie
    ADD CONSTRAINT opinie_id_uzytkownika_fkey FOREIGN KEY (id_uzytkownika) REFERENCES public.uzytkownicy(id);
 K   ALTER TABLE ONLY public.opinie DROP CONSTRAINT opinie_id_uzytkownika_fkey;
       public               postgres    false    220    229    4807            �           2606    33023 ,   osiagniecia osiagniecia_rodzaj_alkoholu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.osiagniecia
    ADD CONSTRAINT osiagniecia_rodzaj_alkoholu_fkey FOREIGN KEY (rodzaj_alkoholu) REFERENCES public.rodzaje_alkoholi(id);
 V   ALTER TABLE ONLY public.osiagniecia DROP CONSTRAINT osiagniecia_rodzaj_alkoholu_fkey;
       public               postgres    false    225    4799    221            �           2606    33028 ?   ukonczone_osiagniecia ukonczone_osiagniecia_id_osiagniecia_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ukonczone_osiagniecia
    ADD CONSTRAINT ukonczone_osiagniecia_id_osiagniecia_fkey FOREIGN KEY (id_osiagniecia) REFERENCES public.osiagniecia(id_osiagniecia);
 i   ALTER TABLE ONLY public.ukonczone_osiagniecia DROP CONSTRAINT ukonczone_osiagniecia_id_osiagniecia_fkey;
       public               postgres    false    227    221    4795            �           2606    33033 ?   ukonczone_osiagniecia ukonczone_osiagniecia_id_uzytkownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ukonczone_osiagniecia
    ADD CONSTRAINT ukonczone_osiagniecia_id_uzytkownika_fkey FOREIGN KEY (id_uzytkownika) REFERENCES public.uzytkownicy(id);
 i   ALTER TABLE ONLY public.ukonczone_osiagniecia DROP CONSTRAINT ukonczone_osiagniecia_id_uzytkownika_fkey;
       public               postgres    false    227    229    4807            �           2606    33038 "   ulubione ulubione_id_alkoholu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ulubione
    ADD CONSTRAINT ulubione_id_alkoholu_fkey FOREIGN KEY (id_alkoholu) REFERENCES public.alkohole(id);
 L   ALTER TABLE ONLY public.ulubione DROP CONSTRAINT ulubione_id_alkoholu_fkey;
       public               postgres    false    228    217    4787            �           2606    33043 %   ulubione ulubione_id_uzytkownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ulubione
    ADD CONSTRAINT ulubione_id_uzytkownika_fkey FOREIGN KEY (id_uzytkownika) REFERENCES public.uzytkownicy(id);
 O   ALTER TABLE ONLY public.ulubione DROP CONSTRAINT ulubione_id_uzytkownika_fkey;
       public               postgres    false    4807    229    228            �           2606    33048 "   uzytkownicy uzytkownicy_ranga_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_ranga_fkey FOREIGN KEY (ranga) REFERENCES public.rangi_uzytkownika(id);
 L   ALTER TABLE ONLY public.uzytkownicy DROP CONSTRAINT uzytkownicy_ranga_fkey;
       public               postgres    false    4797    223    229            d      x��}IoY���+	��R$EJ$h4dYi˖-��_
0.#BTp��CFF�
F�ze$�[��Ы��U����_�g�S���*Q�)�d����;玎:G�gQ�=� ��UZ��_R/�^Q.�~�V�(��ZIy�(�z����I	N��|�K	/��~�b�e�Ћ��o�����'�B.åG�V�H*����$��m�'Ux�Id��cD_�m��G���H�H����4+�"�#��Y�� `0/cϿ�XeaRV�2��:Z�,.7]O�������	?{�D�D�p��S�x/��2H3Q���'��[�g	����}��ɯB���Z���+�`���(�8Z}�����]/���+�<��B��U^�i���d ���D]�J�5�U��V5\xW����&��|���j��E$2Y���Yم7er	���W�T»�	����������jE���/�t�����ǥ�����\��Iؙ���;@����bG8��)�k�aا���0��J,q�6Qr h�`6sZ-=�>��dUq�����Ö��m(/͢��o��VV�X/��t%`6V2���ˬ��<�)��͂ѭ�Wr^�}���[���,��E�k���b�I��\����U��9,�*	EV1,��"H+��#<�V�#Z#/G5�!�)-
����+	�X�a��x~�%y�bQE�����c��������hWC�pA4@�2 ���p.D�/��U4�(I�`s���Y��\�7����&W� �Q������ʮ_��E[�itA ��BM~RPqGka�`_?u�$@��9H�
�L+�\�mR�[����r��k���,T_�Zƺ�'r�[x?Xmj^g<���m�m�������av�]��mϗ1�V�Ϸk)��88�����W�f-����r�8(����Ѥs�y" s�T��'Qz띂\miW�:C�]�R'ayS9��/qV8�_�(��e��X3���ϋX��.n�t�u���7�M�-�lX�O���D��R��KJ�J��z��l�� J)}�������H��B��\Tw���+��Z��g'"FMpu� y�X�۴�m5+ �2�I��hP��R
�^'�� ,��\Z��N�5������U����j�z��*�B����J�b���@�P��[<@h������^�b5MD&�/?/�C�X��YP�m䣤˵d���2���"�	"��~�& ���VO����J&"`FG��lelN��[�%�y�:G�9ᨵ��Xi��o��_�G�"�{߾ʃtX����n^���� )a�/#~0�i�����7��X��mƥ�_�Z�x�v����c�3�y�������Y�Uߌ� Á�7a�}�ܵ�1�W�I�E�G�3i���*�$\��1C{&���9c҃
>��)���=����8^G�����A:b�g�c`4��ᤃ�`��� ȁ8�"��Q"�������X�i2|��m^���͏����������w׽���z�W���_�\�.�_��]�ίί��N��N^��tx:�8�ƋoFS���,�����)ly$-Y��KTIZ��6�s��R4@p�(��h�RЎ��5�*x�>�iv+���J��g�Lͷ+��s%T���9\�F$�:�BE��6�͉P���c��ͼŧ'
~���~�o��a��������J!d_S ����s�]صX��u!7xPGсg��ɖ��S�E�0|T0X#��
?@�ٸ�i���s ��C�F��6d4P���_	����G�4hXg��aI���4�LGD2c&�&��"�eN3�d	f��&��!��� �w����
c��95G�. ��9����^ᾬ%,��b�=�V7�74kX.��B�>�X`TXI���L�Z�	���@�7��!I�Ѥ,Q�7�T	���D�7�J��ܑ �/�߯�~&kZC�(䕁Lo��,0Z�K��ڢ��'Mr����Q� �s8���-\���D��͏���`:�����x6��Q��h�v���x�06/<� ����h��G,��N�hJ�
x�R5��N��4rT��I��� 	�F�zt%��u��:�8��p"%(GH'��O�ô���<<�P�<�B4�h�p� ��tF��"(�x��G~ց�f/�8D������`��Ӈ����A���Q�4=��'*
:�:ϕUF.u"��B$d䡔��n���R���ds��I�������ٯ��ݟ��@o�r1��% 	6SI��胣
F'��.����8�_ae�%W,Z�5�up�������:���#`����nz>yBv6�P����T�=/�1��F�Ԯjx�I8������Ǚ��� H���"�`���5Y�x����)���M]o���M��k+�,-(H�:��|s��!��W��M��W�C�̮sXl��h�J���?y`��T/�
��y"@���>��W�_����%�jR]�$(;y���`�G�\x���fx�
�
Ҿ��Qa��T�W�<��n��$"ꇳ���Q8�NG���h2���l:���b8:���r�a������e����볗g�{���E���o{O~�����!��x ��,G�!M��n�������,YgpЀ^y�\W�+$�{�;�'I6Sy N�f�J�V}������E"7x�h�_��׀L���a
<�<Ɍ��`���Q��-��ʉ����k��=T$�#ʥT��>C�`�I
+�d*h�όQ������ӵ�vD�	�r��a,+g85���G[=�@&���~�Mx��������		�K���$�I5Q�$~���s���q�	�8F@m�|�`� ��/������Pr��+�d�ѓ�p�ce�6H�*p
"��ZJ���Y�'��V���iS�m�a���VH�ٞ����ޅ�L6�<v�f�`��f+�t��VV�h���R@$�|}J���I�w��b�h�~�kn�x�����fg|p�A�7H�Z)hH�U�D<�3�d���x8��������a�鿁i}���0�p���暾��oؙt�]���>�ǲck��;@V	���9
����S{�	?�Aq��_�L؇�<�ޗ��;����rQ���$���J�#!v�p�(�U�r���'�`
3�0������&���32_%9|��r�D��Wa�{,75E�y1u����xQ 
@���l��z�l������7<b�`�6�B�t(�\	4d�{�}d*��p�t4o+�����	@�*�bt	�Bاm�~!8�� :�k:u#� ��A��sC�%@�FE��M��#�mx)t<B�+��_�Z����]��V��"/iw�О��y�X�~��e,�SnB��o�2W��Z&U�����߀Z<�P�#<�L!���(��=ѿ�Q�9�&��_�;��P��\g�5$2�B�3�H�Q��ˀ�aZ�0DX<�`�}xnh��KI�����+�~�O�Ð��'���V1�`��rQ0L �Z���Y��"��X����p:f�7��p4�?<:�j����W�''�'WO�{��oOzO.N^���F��ؒ���p2�6�!���f"�a���?60U���(��T�sjB)6�+\Q��b56U4.��i���BDC��
1�I8��kQ�����1�+� ts!g��������F&x����u��C�N�>Y`�H(����`c1�NV�S-@?$/M�����	 ��eC�.��p�md��	��k��N41)��K'���w�ث��d_ҩE�2�Cc�4G0ײ���Hg��\}0�3�8��gGҤ�I�ݿ�`�����u�1�nȫ�9�+w����H�d5l�,/uJ:aG�r@�(�ڻ�']�I��Q�RD&;�Z#��/i���=^�wh�_��Զ�c9��̕�o�ޓ����y>C#�Ӹ��W�u�qa?����.9�#�&P.�Ag    n�l���	9���'oޞ���zv�ڦ	�ߜ��=�=��x�C tr�Qg�y#2��ػ���N?"��4$Xv!�>k z��a��C2�����2\��V4�^���4�U�s�����)�2�
��h� #�ci��V�0�C"S�f��p�{�VO��^�u�����]&=��`�O�X�N΀����ٕ�*���=�d|  8�������ٛ*���DE4u��Q#J(�ƒ�6�]f� �~e��IǛF�Ƴ}�tqy�Q��@��X-�q�,ka�Oh�yХ����Y+��U#3
g@d���8(�nQ	��$��Mm�w��I��l[	L>�N�����������U�l�0��>�@�$+�����JFIp^I7�o��U��f��a���*�J��R��fZ#h�i�r/Ǡ/��:7��y�C�m6�N��E�H|���A�Oo嶯�+�_I_�pR2��zjC>,��B4����cx4�G�ão 3����4����a��G��=Q(6Ԝ������o�d+��J¥�dv�?���|��w#��O=0�b%�(}aIH�RjL��Ė��Tp�-H�-�F(C*#+�=���Xj� �8�� �&��x���KI�$��/-!�K[�P�*-<@VL̝b�V%����zFG�\Zwߔk9	�Z���`4���������C؟X�,�
�ai5��sU�Ӻ��4(S$Cwyʆ\�Ẻ#EeQxvnc��s����jJ<�ꁬ�:a��BA�Hxb�aSН�&q(İ���&�Q]�P-&V�l R�I�X�y�b�I��� ��.�4�}j���f �9�u��<�X��$;�C��T����E��]�����ut49�=�_ߟ_��^\^��N�?�zw�;�~svz����Ż�+ep����Y���ɻ3���;���p�D`��_�O񗿄�Sgѽd撛�@�
�k�<ɓE�MNe��D���D���a1�&k	�$`%׀�܃Dw���6��m$\(��x���@��^�B9��<Z���;%���/8�Ţ�+�{W�5t���e����H��
�i����/q@6��*����p`����{�hË�a�����;3﵌�.~
Z��;��V�,g����g:���D !��>�";��[.	�DKц���Q�$凄��H�� ����0Z8��\kh�n:4`!�@�����x.���yFU,|�[[B��M��4Xy�
Й��E.*���	��d�ɟ��&�9�0�����p(U"���HJDʩ_'��ׅ��{���튩PF�E�l ��<Cgz ���A�z�[��i$3�w��s8��6��,�<
�����lz�G�x8�0�s(l�u^`>�)��:u���q���4��ҿ��q�g/�ؿ�b���	v�(��{��>a���dr�LA�`Q$�� C������9�.�0�h����p3v���k�������*f|Y�R�^}�8���Bb`M%4�4����{�C���C��1JÃRS&?�0Zz���`+�L9	p�����\w}�k��Ӟ�H�.�E��:�Ne��/IaT6����>��R�W9�J�
.: ��sm�g3�r�]�^�Ѳ[`X��U,ON�j��¨��*�������q|
��CrW����l{i�k	��u�s�
`��j���k�	pu&@kl�&<���:+ٴ���$���Ȟ�}I8���s������гKh�?Z���AB��m\Q��Î��d��C�����m��5��d��os;��_����==y}~vq�� ��˃I�����g��U�m��)o�b��=L?��v/�F���;����Lװ@�_�����5֬!+�0���o���݈��*A�fS��«RgA�&��b1����b3 �Ypz�_T��3|4�vޅ��X��sX&��hF� �;�I}ڀ4%i�m���=�iJ}w����Uu�a�C��6�.��st�W��`W�md�dG��o�DHm������x/��g�[K8��M���Z
�fp4�eV�JE�|_��(��0��ͺ��jn�^s��jϜ5[i�M����b� (���mٱƩk	��z���u#�аP�l�q��1�#���@.�O����� [��'/�G�:{ڻ8yrv���;rZ�~�:����a�W�P��4�`�� ZEӯ�#ש��_��Z����+�7,)t���Z�ا%�Le�#�������,6� �0hbS{;5�ꔉ\��.A{aD{�����FXU�݉�WsI��>���j@U�1�t��.�|A��A4�6��v�u{İ_%2sV�*��BvX�'?�6��*�ƍ���I���O&Ĥ4���Z	�0�5�pZ�Y:��Q����XV��&s����t�]��f���U'E�Q�2ͮ���U�g>�?`��g?�
�\�5F��d�P�B6b�D&#��v[�Q��T���P:�LM�����V��)R�������p�7�뽓0�ޘ˖�����?[�y4 �x����L�4t^�p-�������d�P�=��Kh�u��&nԝ�"��{{�����?4ѰS�����b�m���	*߂��Q����������hi�w��҆	�БV�Y!�(���6o�Qi�:C�3��'G�����3�5��F(���B�H%�!F�5�6��{,ڣ��=�b��ڈ�Q����x{�vɈ�B:1F��?��mǒF�=�=o�NOY�E#���+M�dFqt��Iv��1w!��j�y߰�I�E7D��ٟpF�p��n$xH�!������#ߊ�"b�N��&���1:���Ϯ�zv���Wo.�ނ������ME� �Ѱ3윂��h�~9���#?Tv������bVY"k�0|��e�BD\�V��v-��S��::�[C�$�������l�gI6�+	: -��M��i�m��0zԵ\t,�	�<|jk�����
s.�)�\JuO��59Z�2"br躜v��n��*M$j�-�f���8-sܩ�a3�r� &@�L
�2m�B̢u���%Q2x��fppܭ8jQP5����0m1�&�Q_}�vU1����7�k�H:T,q�ClR�GK\�S�kjL{]�YG��t�i%�˼�E�=*���C*;���Me�F��d:nP�y�h� ��B;C�!@ē<(�� ����� l}��B�1�9�P<C��-+�I|���ޓ<%ۭ(��I����*��R�=�(f{��MA[�3oC	�c�dgX8�GK�}���T2��3�F���^ZB(��q߅���T�k�v��F�l��52�*ڗ��IE���-T>{�t3���51Y�ͽT�Ht=�i�����6�*Ջ�V,�JzM�5zk�ͫ5�YE�A�l#3ю�$��e�EN�`,]��I���h���|��S�m	}ץ�B.���,"ad�:����aF��H.�h���/䛣Q��&�o�:H��"l��϶�`đM�z"Oa��hI�����myTO$�A
'��)�G��Cc���aU�pW働og���[���g����m�����D�:�0�ϻ��"�1e�U%'-�@1ǁRP���+����p�%�t�O{A�o��S�X���+�1n*$֥������V6_�<������n�Z���\$wb�c�o0 �/ܛ�T���l�r��
�ˌ��)�o�:�i��#f�̏05�/�t��S#�:�E�8* [���غ[�Aj�N���+�f�6"GQ`Cpza��
mD�3D��p0� )�� �����g�"��7"�o�X{+������3t:d����D=Ua�xd�f2���=ыk��ȍ�t�� �i�E]�Q��:㡻K铇R��b������_`����lkt�`]|�eACV�QbǏi���Õs��X�KӾ���@�M���T�cݚ
3O�D��� mH_��hf`�\a�Q����@5iP�ٖ�t�A���j�B�����<��(}h�7W�)smX4"��]�    "$���(.����xj�s�:�ZU���N��4��b�����K����۲�3��!"�zNڽ�a��yz�y�g���At{B���G�Q��` 
<���C�P�(^�����ڹ-�~�N.�y�z��b�����6,��"6K��N�	��`e��@����:녌<8�2�!�?w5����)w��"}U�Z����$��'(�H9.��)P�B(�ܭY�����]K3��m�`Վ&�D�2��*r�>��{�8,�ڊ/1�m	�V��6s~�q%L�M�8�ɍ�d���*���c�0O�����`j�K�XC�(WoFv�8+&�����c� �|�AU��!�q�3X36a4=���o�J������m�2豈կ��aB#��rj�T�$��n%Jk��^�6�G�$R���I
��'��D*rP�J�b>5���z��q�g���~%5��O݋9��h�W�j�=��Ti�M%e*�M�v��-aOA��j� FUu�ck�����"���P���uc��TR��6��XUq#�k�]pa{T�±I�E(�a5ku�g7�7�TQ��������w�c2�{X���-��rlǡcl�D�W�ѥ���	�ab��.�`��e!�hZ����D�����tS1,�XKUXA!�s����YC���K���p���>���ڵ����ӄ�]6�]"7I�00d���j�{������52Mzפ0�K�Ꝋt�=�{W�b"{�Qo0Y;��Igܹ�$H�m,J����3N���߸�����w{�G�ڬ�����Ң���0<���b&�Z�5�`־N�F���t9��U�,�3P46�S��xڹM2�I�2Y�1C��:=�a�.�a�%5ʙm2�s���-�q�Д�ZB�+&�Z��0��%`K�5�.�խ�\�-�j��=�:�Y��y�'k��?3q��s�a[p���!j��A���K��	u�$��#���g�#V1;��G8T���=T�M9�zdt5w/��������s��TB��gd�`�O�~V�����n�mMb<��8���	'��dz3���M�����~{yq~�����N���x��G�S��@�d�g��G�Բ��6TyA�=�"$�GWj�/�n���a԰��Y�P�D�ۋPu���� ~ޮ����(�5m��Z��Sk�HQKi�S�^�R�dL��r�6�b���%��� r��%Q��?Mn�c��I��U�FZ�K�t�y�Mo�l5G��n�#�G�Hb��I���E��W�ɨ��܏nOM���ؚm�����=��1��]�t;'�����k{��ؔ��la?0�Ɓ;�K�[
J�����U���#[��8�\o��l��~�5�f��㖚�2���쁿�y��wK*P���8+�WLiQY����l4��fG�������G��Q筈�=�)��fz��$c^tҊX6]=�t5�?�������������T�E�+�{��@�a*<3RA���dv�p:�j�x\��]���}��B��l��:#�6[���Kr9�r�����K��ab:��`� �����/]/�w't쉸��_Il��A��\Qhw���������
rW���� ��$�6#��N�[s����	�B�T�^_��G���g�״�5k�q;���=�����W�D�4X���bR�����u�Y��F�̀��E�ۡ�Z57�׌�%|�c�m����o&��ax
j�]��'#1/j��K�uL�'p%�TU�c�DΤ�b�2�����7ә?��E(�j�T���ȟ�������p6|s< X{�70A���W�l�aU �B�#� ���V�c�.};�C����c������l��i��E� ���y��W���I�����("h �������2�AT'�Zܟj:]R�޾�P�b���M���N���M٦& b�������E+�����mխH�zbm��f�l�6�m�D�j�C����n̉�*���{�B�j�+x���CࣀQ��~n�q�����s�&��!g�����Ӂ|(���X�_kH��Umd�����.���Fc�����}wv���wq������ӫ�����vɿ���q�S��
��Và�{L�*6P����1�3Uv�SW�[r!�(��u��@cA���ϳ�i�	1�[�3�2.�-��.ʽɧ��B��"(ʉ�)��*�������
�F�ؐ�M��`����T�o4���Frf#��1����D�����r�i�������nÖ	������jZ�R��|�me*��φrH�7�hv�q}8f��W�&yTWC��I���j`���UM�����JQ�D��"u����|,�S�U��Rj�޲q��J.�ߧ!)o%�~<�~Q:�*���8��gW'���^�\��K��.�v�oLr: ���/�߇���㍍8i��b�ft�$DA��@�?q
�t����؈��w��y��.�.�(���x
K��5v˹�h8�F���{e�l�2�cc#�X�Uõk��hWo��y�u�lt5�ft/�HIm)��E �e�JuB����ݤj;.�_�}��b_��`��A���QzWy�F��K��o����f"�{�T2�E$��E�h�
�b!H�ڭ,�9]��"����d|��A��["�I�.K�kP�H&r�!$;D��Ό��N�v)r}|_��������h���?��A8O�7s�:r�p�����Oz���}wv����Eox��M��I��D�ҾjZ,F���]7�~"����q`d��"F/�+Տ����וp0r�x�i(�p|���q��>�3�}x��!��U�T6�ɵ�q��'ZL��\�q�m�Z��#N��9��S�R�M��Kg0��D�]oiYx_���u��l�5��Is+�)[T�Ý�zT��5<f��l�.�Y%�u��:���t��{�������w�ت����z���׺��	�n���)�*��p������(�]�%��M�+_���xLu�o��k4�,�)	k� g T��X��=����O[Ճ���1�tI�u����Xl�����P	O���}�w�Ω�J�$�����E�S�'����)Q��\}�_�;�wġn��p+��}���n�)�� ���Ox�9���N����M6j��=���ZZէ���pC������<.��O��(e��r��������/eB;�}u%��?2Ņu�v�è�S�{���_�Rg�[���p�2��fٻU�����.�y�\��\��Du�N<$n�'O�m�b0����87ٳaǆrT�nC��g�BP	+��؟xa��5��E�o����l)q���i<?9�??yw�̤���N^����~w�l5|ԙv�=r��p�˝_�}�uZ�N3��N׮2_vO��l|�b˺���vB������b�S���/�n0 EC�5��i��ؙ�z�;좷�у_x6`Q��c<�T����;w�w�#�^�m��֠��w;p���Ʉ�u;zQ�HJ�Q����}U�ZXv�
}���-���;����h�aב}�����Gv��G�?m��>b��m��E��b�阒0��f���Ԕ�����u[����: CH����=�˰?�߃?�a�;���u�1���
��Cx�(���~�>h�5�e�������ҍ��}lC�����*�Wz���.��U{J*ie�:W�P'8��;���#9�߭e�u�H�J�����c�k�T���v׷r)�zwd+�鑝����U�.����QZ�H�~`}.g����( kml��f�`8h �8q��G�K����h<7J���z8�^�79L��f��McV�M/�k���F�K����k���VC즗]�\��T.�y٠~<�X�T���2��������W�K_����`��S*�m'���mKV���%��"�N�y��Ӫ��~��@�|V�
>}}Ć}�<C�h}W�K��J7JG�'��I��)~��Iݡ��=2x���@�Ǧj�K��elt4%��Y��/%G*�}����79uv��w T  _?ٶ��5�r��� .x��ͮTV������]���9���>oo˛?��jw��o�U�݉���&��J�s���4{�z�9�(�谑�cڨ8�F�o��c�������������L��#��x�q��s7�NKm�:́����H�Ұ_l��=��nm���t�V%�e����&Y��xlf�%���=���%f﹌���҃9��Z1;^6�"�]�II��'Ք$+L/2:�k�+�
c�y�n��C6��Hٜ��a������B��I����}�{�V ��G�ｽ]չ�C&`��7[^�>�� �Ri�S�P7�2���c;	k�R'C=De�ۻs'4A閍��7��m����@�f4w�f%ܡ��I��d-3�-�E��.L������2x��*��em��P�s�J����!���+$R�t�`�-d�*!O��@��5,�[qz׸��N�����;�b�r	yCŜ�F���o$B�wiS�S�N8�Ȥ�ʹ��4��|IʔZ]P��~BK
��V.uRu<���2�㜊%�n��c^>�}��.�1�s��u]k����f8q½OX�K��o�����j��      f   Y   x�E��� C�s�"Pن��Y��m9ɷ'��Z���h�ѩTϘF�����b
;~�tF�MZ�ou��!���p!��X��(�<���      g      x��[�n9�>�OA_��)H�J��ۺ�����X��@c/�L��ʬdM�L!�6���y��5t���� �dfe݀$K2��/���g�g/.^,�pq���������w�<;�k�U[�b��s��R���b����߫~+v���B��0믿Յ\�?�J���܈��ܔz��j�#cA�N���KY����j'L�J������A��6k-6����l>�w���.��^i��W��O�Q��o��Vb/��nue�q3�Ƌ�u%~TU^�hD��R�ɐ�)ծz�{�G.Ļ�����.ma�����Z�s\y�{]AW,ﻉ�+'��m�ȴ*��kۗCdӪ��/Į�����V�F�]�v�����J��
��ۉ��Q���*�s����B4���o+�	�`�A~�k�7e=�\u-4�2-~��I>����<�Sd
�ؚ��\�b��G�>�7��En��R;u��*!k����W�)L%��u��k��;��Gk*���O��A��
���~��Ì������w���r�YB�I�r���r+�$�(|Օ�J�����T�ı;��������w�T��>'a�=����!GO������^n���^�#���_E8�3N{���ʡ�!xvvG�AUbu_��o��v�ҪT4�4��!f_��A�wI�B�5{��V�`�~!~�Ֆ�Y��=�������Ai[�ع����=�B�Ʋ����䯝�:nY�4��R�R��s�1
�?�"�7.�Q�`\��A��CK�0<��J���h�
Ayp�Y��r�$��٧m9j�$㱐���~�m�]��ѵs�(2�B���Ȇ\	��i��f�*L)�D�*p�ۤ��z[�9$bn�#�q���Ǖ��KC
�*��5:�I1.��T���v����n��9�mҺ����Ii�-�`!�'��;�$�AU���f�ʟYV���jV�V}�ͯƢç��+~�-FlAz&��i���>�`=�s+��b�O�Ҋ�+�=�;)�^�7y�Q�����;�wJ�v��\�s*��C��ӱ�-8���1*�Bo�C?VU�W������7e�_�%){2W�W=�SI⤈�4����?p�-�
��??*]�uN'�� �#©ʳ;�CaG���Q��n�]�c--�]_$��e�"~�FK
��/+�hk�+8���jU��a|l*]��G����A1���'����w�GT�����6l)S�ac�B�����r7?��a}W����=,i��Y��V���-��"��J�W��XL��ؙ
\�4��ȵ��0*�*�T��]&���ؽ���=���#���?є=qn�p6R�nK�*;�1�#���LbJ�#U�Ȝ:�<YT�f��CX��P�&%Ie?��Qb-�,T�VL��\���1d��i� �rU5�ާwk��I'��u�A���^O�ƚ[���lf*ybY�����]ѹH�{KN��}�6C�Q��Sv|ߡ�y���7����SS�����zQt;���w�(�<�D%,U��J�?�ȍu�$\t}8�x��7C�g�f��f����5��N��<���L*�p��*C�����#�L$� �L̸�+l�7H�1nF4��}�dJΒ./���-�^%���o�>���UD�u�ȕQ��r��z-k�^_'��Y�@���S���j� �RZr��ul�Q������� �� �ޭ�8��;)>>��k��M� G�$����5�1���ؘL��a�؏�P�Z�*Cr8�+P�)�ڠ�v�t��mOHzC��{ X��q��B|@�RB��2�Z�({��^'��/���C���е1��!ݜ-�X�Lqr���WDp����<�< wX�RV������H�A�pJt��m�R�@������e�qCۇ�����? (�9��&r��I��K��ow� J��̱I7Ui�g�8;=	�`�����������W���jir~�p0!���l5����;Y���u��N{	�Tt��n��_X�s���8�V�V����ɠ�O���8��4��		��ڦi�����>�Ω�`�|\����Ib�Zn
�ç�jχ���IB�{���ow�"�V���N�E���*��/����n
�s0��}��.�@o\�,�Kt��#��X�b��\�I�Iv�!�}�/B�`�o��1��� �hmI��	wy#�B�"��d*�(e��D��sK�z=3R����.5�I��ߨ)-wM��L���śVdl�R�P)������SF�7uX�*�K%�ű��0��>[��Y���§����k݇K�&=덹����,�#�M�]���[G�΃�ˎ��ƀ�9���*�Պa\n��N�׫�_�g±
�L=4w���dݠ���H�H��!�cž;�^�7�j@:^�8z���(�'@�;hekȜ������q	��O�wq��U
�t3��9e'�wFrw��L4�{���+?�ٍ�Ҩ
�R,w��i-��[���kv���̾c���BN�%I�31��-&$�Џ9��h�	��
�"���2\�%Q}��sҌ����4�5��7�w�

���iv �h�� �Ŏ_���t�9(�k_�0vUiy�F�}�QT]��]	?�F�	ݩ�2�G���2������1��i�jZ�"��&�$ϬXyS�X�Y�����$D�P�yĜ�Hr����b9���*ʪ,�����1��͓�K
���<�/��.���y��=bx�mr�q���<�|�<Y�p���U��p��aSD����n�7�t8�Cq�G[$��
�������7�c�o��CKe_r��,�g��Y��̚ξN ��(����|a�M
(���/e)˓����j�l�9q�'�Bh��Q7�|�0����3�������a��:2�S���g�MG�mc�E�x�KF/��*�+?��u��	a��S��r����hR��)��8��E����i�G�q��x�<�#✫4{!@$��������C���[
�$���ۀs��s��� TT�d-�ي��P�Xs�"^Q}�=��@�!^G�����a��e���1p�$��F;D��)@���:7�ޡ��%�<�cy������>F�ȺN��`�[�l®'�'��w�%HHY<���5;0&^�d�5�<w�88EMX���G�P(i�q�����{������3�z��h=a�Z�yE�>�TI�@U-Z�(e�_mF�a�ሊc��-"�. !s�n�^s�������e��5�JV��5�[}4��5���9q���'��x���	���Vc���3�@)���(N�B��uF<�|�c���✏ �lBl?z�:O��7�#8@CTD%�{]���s�A�EO�Raq/z��sm��oe&K�N\��J�{��2lw��O�#�׻�ۏo�3n!�_Ŵ��z,q6]3X�3{���Ȋ�)��+�����SrѰ�7�4���^�nf�����´Fԗ�U� Ш�b�P��N���ZK��n���Ȕjh� ���ڛvۛ07��[^���MO�z�pE�9�̈́W(1�}�`v�6���a�:B�s�S��Z�r�dK�@"�)����&#Y��-�禖:\���E���U��D'Mu5xV4��id�<�_�W��~!�.�ҖE�γ&P�N���iUy���27�dY��r�>�t��f�b䞢Ґ��[_{�mu���6���G:�G��-��%B��h�0�Z�������=�F_'��;�p�H�2c�x�>B�X\ڋ������4��4�!ڮG\����
��EV�T-�cjy��YJ:ZV��-�sr���JY�x�6����)o�ʈF]!�LG9pNzۻX_眔7��!�FҮn&O����l�8Q�/t�� Ѭk���@Q�����E!�gSE�A���x�͜u�H���5�L���Q�a~�9���~�K�Za��%����D��^X�;>�DԇDB�&�>��������w�{�<K;fO���E��t��	����[�h���c�:�Jd���5���X�X~�l�I��H]�×]5 �  �l���9^�SH�/Y]����ZV9-\�]��x��#g����@\!�����G5n�+V!%���ZH�������ˈR8�\��|Ʃ�W�r�P�{'�<�p�����)����A�Vt�μ�A�fly'v�'J�e��q�T���H�^��e�q��v�S�AO��q[�z,��JM��|�+8�O���;O�匇x>��E�ԛP���s/m���ťe����6�1wb�+L�эSЕ�?�h���+_��4��Sw���Q�_z	{h���Xΰ������hslpDK9��-� �L3��)�]�����D�`����R���َ���7W3�F0�tU+^���Te��-��vU���,�����P�������>ŗx��.������f�r0��$�X���"�߶�#�Gۢ��}�����y�M7���'�Cg�7#UK)����ToB'2�^	a�u�����@3��X���w�q��K�7�E�c�̼9n:|-uqe_���7ɥ��c�F����b^�&q��_�R˳��G�_�J��Jm�K$����;"
�>�d��?�/�ԭA�,�Z�=w�tOi:@��\j?�&�����&�ezG�Īe�:�5��3������(}U��+,�{3��YP���Ņ���a���B�d��KQ��8�:�=��K7x���l�i?:��x숊!L���:���8㣣	��㼩����R��y��-�={����2      h   :  x����n�0�g�)8�K Q��jt�]iAV&�d�՟��X �C�1�v��^��T�2d$����tw��<�6auyɢ|y	K��¤۔G�s���#���(X������,4�xp|�BK�T�Jo����'��L�`�F�T%|�%x�`�:r�Z�$lX����)�d�F�W�fI5��XR���
?h[��Ҩlm-h��י#�Nd���(y�	�7�Q�;�_�:�$kP��xt<�M�ٜOۨI�O�`syj,$yf�6���A��`R�5����kԔ��<��.�}r>ţζ���Y�>�6؂O�;��� �3��5���:�#� I[�#�w��h��)���4*k�$���J��3ė��",����&C��s�Iy�;��a���y�،=䇷{��:�p;t�����4�y�H����y4S��.B�9��~�C0õ(���	v��c��J��hYj����fmi1��B�����S1�2�7Gfg��<�������e��	n��c�?4oRL��G�a�F�ҽg�NO�z�ȳ޲���=�#)��[�q^;��      j   0   x�3��M��/��2�tIM/-.I,�/�2�tL����,.)�c���� B�      l   L   x�3��,��2�����2���,ή�2�?�9%;�˔�=3�ˌ�'3;3��˜3�4�˂3$��43'�+F��� ��$      n   5   x�Uʱ  ����?��簅�cM��HO�{Z5}U�[�9�ɷ |#/      o   '   x�3�46�2�4� � ��5f�@�ؒ+F��� p�e      p   �  x�u�Ko9���s�\��RO�m�D��6q�{!)�y�y�F�|�U���s����I
&��?��tc����g�1���|�.c�p�8<=:{���6�Z��	$EV�ޜ��I)=P�h�Ƴg�,J��1ea�S���sѿ+=_�����qܵ��z��s�O��zy��B�گY*i�ѵ� ݻ��jT��#q�ثFSRuHYrHLi���]{KEC���ίvx>�/�Aߕs~<y�mƆ�S,1c�D́cS��k(\�f�b)�z�j���H�4�<��|��nQxP�׫�찜�-�ۛ�W����O�g�ZQ�:���!g-�{�*^*�Cl���#c�H�K��F�b����[�����j�&��9]^]-��zy?�(uFcʭ[�PC�؆��Hn����r��̭aM�N9O�7ܲ���vXnÑ?|}�*�ǿ^�u0�H*=��[hQ��R�P�]S.��H�bu�n�1>�8f�w�-�l,�â������ws���e�A�؝�Ջ��������"�*ژg�:�UBw�3U�=����[�����>y��_~����C���Jji�K�!u	-I�an.�Ǡ h�*���ݑR�4�A�(8�hӤ��)Lځ�~��7����3�G���,�1,�9��ȽZA`�ыq��͚�7�1B�q� i�Rr+SJ�&��e����L9X���9^���3�I�s�Ɓ�DQkE���1�ٓ��#�|h��Fl6Ry��#[��^�����u��     