PGDMP         %        
        {         	   MovieData    15.1    15.1                 0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    17169 	   MovieData    DATABASE     ?   CREATE DATABASE "MovieData" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "MovieData";
                postgres    false            ?            1259    17434    genre_id_seq    SEQUENCE     u   CREATE SEQUENCE public.genre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.genre_id_seq;
       public          postgres    false            ?            1259    17435    movie_id_seq    SEQUENCE     u   CREATE SEQUENCE public.movie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.movie_id_seq;
       public          postgres    false            ?            1259    17218    movies_genre    TABLE     g   CREATE TABLE public.movies_genre (
    id bigint NOT NULL,
    name character varying(200) NOT NULL
);
     DROP TABLE public.movies_genre;
       public         heap    postgres    false            ?            1259    17221    movies_genre_id_seq    SEQUENCE     ?   ALTER TABLE public.movies_genre ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.movies_genre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    214            ?            1259    17404    movies_genre_seq    SEQUENCE     y   CREATE SEQUENCE public.movies_genre_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.movies_genre_seq;
       public          postgres    false            ?            1259    17222    movies_movie    TABLE     X  CREATE TABLE public.movies_movie (
    id bigint NOT NULL,
    title character varying(500) NOT NULL,
    year integer NOT NULL,
    runtime integer NOT NULL,
    director character varying(500) NOT NULL,
    actors character varying(500) NOT NULL,
    plot character varying(1000) NOT NULL,
    "posterUrl" character varying(1000) NOT NULL
);
     DROP TABLE public.movies_movie;
       public         heap    postgres    false            ?            1259    17227    movies_movie_genres    TABLE     ?   CREATE TABLE public.movies_movie_genres (
    id bigint NOT NULL,
    movie_id bigint NOT NULL,
    genre_id bigint NOT NULL
);
 '   DROP TABLE public.movies_movie_genres;
       public         heap    postgres    false            ?            1259    17230    movies_movie_genres_id_seq    SEQUENCE     ?   ALTER TABLE public.movies_movie_genres ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.movies_movie_genres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            ?            1259    17231    movies_movie_id_seq    SEQUENCE     ?   ALTER TABLE public.movies_movie ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.movies_movie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    216            ?            1259    17405    movies_movie_seq    SEQUENCE     y   CREATE SEQUENCE public.movies_movie_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.movies_movie_seq;
       public          postgres    false                      0    17218    movies_genre 
   TABLE DATA           0   COPY public.movies_genre (id, name) FROM stdin;
    public          postgres    false    214   ?%                 0    17222    movies_movie 
   TABLE DATA           e   COPY public.movies_movie (id, title, year, runtime, director, actors, plot, "posterUrl") FROM stdin;
    public          postgres    false    216   x&                 0    17227    movies_movie_genres 
   TABLE DATA           E   COPY public.movies_movie_genres (id, movie_id, genre_id) FROM stdin;
    public          postgres    false    217   =?                  0    0    genre_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.genre_id_seq', 65, true);
          public          postgres    false    222                       0    0    movie_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.movie_id_seq', 174, true);
          public          postgres    false    223                       0    0    movies_genre_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.movies_genre_id_seq', 21, true);
          public          postgres    false    215                        0    0    movies_genre_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.movies_genre_seq', 21, true);
          public          postgres    false    220            !           0    0    movies_movie_genres_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.movies_movie_genres_id_seq', 524, true);
          public          postgres    false    218            "           0    0    movies_movie_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.movies_movie_id_seq', 3, true);
          public          postgres    false    219            #           0    0    movies_movie_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.movies_movie_seq', 1, true);
          public          postgres    false    221            t           2606    17283    movies_genre movies_genre_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.movies_genre
    ADD CONSTRAINT movies_genre_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.movies_genre DROP CONSTRAINT movies_genre_pkey;
       public            postgres    false    214            z           2606    17285 G   movies_movie_genres movies_movie_genres_movie_id_genre_id_5ff3c723_uniq 
   CONSTRAINT     ?   ALTER TABLE ONLY public.movies_movie_genres
    ADD CONSTRAINT movies_movie_genres_movie_id_genre_id_5ff3c723_uniq UNIQUE (movie_id, genre_id);
 q   ALTER TABLE ONLY public.movies_movie_genres DROP CONSTRAINT movies_movie_genres_movie_id_genre_id_5ff3c723_uniq;
       public            postgres    false    217    217            |           2606    17287 ,   movies_movie_genres movies_movie_genres_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.movies_movie_genres
    ADD CONSTRAINT movies_movie_genres_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.movies_movie_genres DROP CONSTRAINT movies_movie_genres_pkey;
       public            postgres    false    217            v           2606    17289    movies_movie movies_movie_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.movies_movie
    ADD CONSTRAINT movies_movie_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.movies_movie DROP CONSTRAINT movies_movie_pkey;
       public            postgres    false    216            w           1259    17311 %   movies_movie_genres_genre_id_c3609db2    INDEX     i   CREATE INDEX movies_movie_genres_genre_id_c3609db2 ON public.movies_movie_genres USING btree (genre_id);
 9   DROP INDEX public.movies_movie_genres_genre_id_c3609db2;
       public            postgres    false    217            x           1259    17312 %   movies_movie_genres_movie_id_ff5e55a1    INDEX     i   CREATE INDEX movies_movie_genres_movie_id_ff5e55a1 ON public.movies_movie_genres USING btree (movie_id);
 9   DROP INDEX public.movies_movie_genres_movie_id_ff5e55a1;
       public            postgres    false    217            }           2606    17363 L   movies_movie_genres movies_movie_genres_genre_id_c3609db2_fk_movies_genre_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public.movies_movie_genres
    ADD CONSTRAINT movies_movie_genres_genre_id_c3609db2_fk_movies_genre_id FOREIGN KEY (genre_id) REFERENCES public.movies_genre(id) DEFERRABLE INITIALLY DEFERRED;
 v   ALTER TABLE ONLY public.movies_movie_genres DROP CONSTRAINT movies_movie_genres_genre_id_c3609db2_fk_movies_genre_id;
       public          postgres    false    214    3188    217            ~           2606    17368 L   movies_movie_genres movies_movie_genres_movie_id_ff5e55a1_fk_movies_movie_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public.movies_movie_genres
    ADD CONSTRAINT movies_movie_genres_movie_id_ff5e55a1_fk_movies_movie_id FOREIGN KEY (movie_id) REFERENCES public.movies_movie(id) DEFERRABLE INITIALLY DEFERRED;
 v   ALTER TABLE ONLY public.movies_movie_genres DROP CONSTRAINT movies_movie_genres_movie_id_ff5e55a1_fk_movies_movie_id;
       public          postgres    false    216    217    3190               ?   x?%??jAD?U?b???rbܘ??ds?Џp????ⲨS?r??试IE?????s?/?(\???t???ߧ?0?:?l?[??MC????Q??D7o????9?T|c]?O?7??{???]b?g?Y?n?S??FO??y?٠t\?u[\?K?6;?Y6v???	?? ???=?            x????n#[?%?????`N )IJ??<LS???BN?$*?
hl?o?N???Q???????C0?B0觊??lo')?O摢???x??ef˖5???HO???N????????=)?"M?N?}?DE?"L????v?s?﹝$	???gI??=?Se?q???v:????H?铛i_'E?t?C?:pǓ4/r<$)2?n1?n??g<=?3??????Q????4?ü??n??i??-R?d?>ky^:Jҗ0-s7?7]$:?????̝?????<?˟??:վ??*M?4?s???????h?<v??7=????=?7??F?߽y?~8[??7??Űًo'?i/?u??_gg˿????_???????楷?????|?_~4???_???|?OXU|?Ӵ????Q9?j9??g?<S	??{???G??i???П(?|?3,?E??i?t?????wC?h??oϽN]܈oZ?}w?r,瓊e????p}???Ue??\>%/??Oi??\?u?S?_1Q?????g??_in????Ş???ŗ???9pa1?g\??ʍ?<??bh<??S??6?c6c?Qy?۟~o???}???,{??Q??G???$ؐ?q?/z???7?\?:???f9?Y??A?o?-?@????v??g?\????*#?k:V8??a(?[????=?*?$??C???K??*?y???I?N?q!?:???_u??|??rU:e??a#ݴ,Fʟ?/1n#V??>?????:O?????B'?ؑܝ???i=?a???ӰX~x9?,i?=ꝿ]?????WX?op?v9?9??PEZb-??j4>;?f?9?T???Y???w?&3????r<??BE87????4?y?K?6ź?{?Iƕ??$ѓ%?I?????.??O?N????I??*rU?ń????eZ&cwX??]`u?v??6d:/`?TR|xżU?{??f/?Ί?ozs??x?????N?N]?W??4ι?lo?c?i,&?????R?ʽ?1?5~??3?u
?p\?ך?J??0?C???	??5n8>m?kϴG?wa?-,Rw?.sw??0?c???"(??4???-????$M~??0???6??? c?? |z?Mǣ窘?qa?ܑ?2qc??$-?q??8?{?Tr|? +?x5???+?ŕ?????Uo????|?f՛简Q?ճ????q????P?x?8<?4?X|,?I?RZJ?֯Pp*??/?"?'խ磗?%n?v??X???L??5N?w|؄ȍ?g{?S?3_hw??qH???v?X??.0?s??"\X?ǣ??	??2w?t????Y?X;S?a??????3???fK?kpл?/??????t?)>?r^?\?O8?ǎ?#?"?@?e????2?"?6?).??W????4??hj1,?I?<N^?eX???Ӛh??a\???x???1???"? ??B?L>(+#"?0Ɂ/?73???c?sx0^?P??f-p????1?b.&8??w'%?.W~>????K??w?x????co??Oi?y?i??s???=R???V?^?7.{?a??)z?1?"l???V:??A?|?>????ꮴ?3لӔW?*???? ??%̐?>?"]?V`mNp?t?G??\B>`???Q?o??bq`????ZNt??f???S!?b???E????\n?ڊ????,?-/";?Z????I!? ?(?p?>O??I?v??x???Kc??Mg??ԫ?!??o???-?gl?	?1?mrt?:?
???j8X==????w?0??ݞ?ϰ?????L?c׾?,??P?M`;"pxX p?'???????????E^????NW??\Er??{?3r=w?k?cU?Ȉ}Y????x^?w`?'X)Z9n6?G|??a5?u??????g/????}??mK5[????)&.?}??7??{????p??ϪJ?xB?sۃ+????a??c?????-???=0??j?W%?M?9?/L?y*??B,1##w?-v?ilp?a?=&4⧽?d1???+?1?1D??????i?u~??]^n???aN?Z?w؛??~?l?k???Ag?????|,ǕίDt?ۈU??o6[N?
???Ԍ8u?=#|?v@t&?Ia???4?i??Ǿ[J?XF?=???Y???.??p:b&۰?o????[?	æ?e?L?q/?$???{	H\'Q?>?#??<c????d?T??1?Z,??p?ϯ ??Z??K??9??7????????^??<r? ???<?? M\?l?ݓ???????
ig~?o??????r?4???pjudÓS:Ə
7?<f$?]?e??r??Nn??c??@?4??8??i?
|pY?????	?
?09 
?Hn????2=?$LpP=??&?y91x/?l??#???yU,?}?'???D???Q(?6i???????u??6:?]c?/??[????ƻ?v???????y?0'?ZIk?/ ??d?Z#F+ʔpo?C0?g??K?k?#*?e??????|?%?N?????s,?.Y(P<?EH+?䟸R?k?7T??ʈy?w\b??Hh?z7
g<	??f?W?Z??c??~?????x&V?7n&?Yn??^?7 ??P??A ????J?4???b??J???5??????9M?9>*?@l???y+??kd?z?u?$Y"?????t?<?I?????W;?????d??K?>??(x??)?%C*ؕ9[???1^?@???ٕ??/V#??)$??m$ɯu??تE*?6'h???7?kL7??-c?:~3???]????~???!?:?J? ????????p?a????8?XΓti?'?$u?ᩚ+?'0R???-(????L?o?kN??????l2?x??tI????-?y~?	?u?(??4??
`??%~ɷ ?NNKi?66??????2NK?[DT?Mp???:??????/,?'???	ҹx?n:/?~?%of26???ߒ??}??? V??$D??#??????._?Fc??d?r	LT?7?ǋ?ԛ?&????mʲם?V?-`???=v??@1=v?4?7?*1????w:??K?ᮀ@??J?а-ĥ??'-??[K??fD??)Yy??P???8???{rp?p??????i?8?|?$ ??ϛ|??[?R???#V0?3??8?_??m?ո?1@?=Bb??uw`g??܅f?{??K?^$Lb
`??y??O'l??????W?4???E
?I:w<?=x??$V䰙?-N2??G??????J2{V??y??h???i>??I? E?I??T??,2??|r??????L[?sG?V3??L?f???_??????%v????[p??c|?yuXuz???.?5X?@??K??]?ÆaB ?e?It?&?S>[:=X ?{???l???%??I????͈U?n<???K?s?P????V?:Na?6?5?̠??`a ???g|????3??8?zw?}h?pS?1 .?.Ĵ?
??vs??'}??\?????]???`!???v??¥?????.???t"??I?????Y?z?t&?,??L???1?
???'?5j????l?JДk??)-&8???[??CD?x??DI??'I?c`M9?Ϻr??\_X?|Ƨ?J`K[?hv+?J??xz???9A?:d??R?E?.?<k???r~?NLcr????K?Hpbs3w??aOxƟ?"?????iQ?^??4?W?I?k????ҵ	O?If[???Y??cg? /????w??:N?9????? ͆??4%?N???U??T??o^?????f.?#i⑀y?k???|???M.?NwN׉_?Ө???Ǯw?X??]????z@8??m????p>??iy?ˣ?j???b?'?DwaT?:?k???c???Y'5?:?5~`???\???Zd???qh?qv??`??8M??G`???_???x~prpy ?j?*?M????%??N?-}I;6?2<????cˬ??odGt4g
?'X3w???sDUϒ[??<?9????^??q???.Tmڹ?;k??c?S?<{!???6??N$@?!S???K?``??#^??t??B?
??? B?0    1?,?R???????0fA?4YI&??y\?ps??	ʌ?gn??"1V?2+?s??X????-wWn??D?????6L??<_??z?4?G?M?i݁??J?L?????+G?G%N???N???G???"1=?Q??jDᳩ?K?!?0;f?S?N??E?v2?u?5_?Oڀ?{?1h?3 ????M???)??]?̛<o'??x?&}??ΰr?Ϊ>?????5??æs??I.??8????)??L?s?qT???r? ?7B??y??e2&0|?Ju?Y??z?B?""1?y?]A?.?R>( J?????u?????K??1ʚ??3??C
????2!???<?l~?RV??ۙ)?zT?;??
?O4=?D%f2vC@??٢2?/s<?aD?{E??ʙ????3|?1X<?ƿ?x?$-?e?qk?Y?ZW?c|V`?ޒ?`??L?a?+?7????D?ͱw??@??йe???+]`wq?L,????Wn????-f???B*??1?????$??;dt?D??x8??a?GTf?#8??U?????̉Xe[?e?+??N!?-bB݅|HY?*?
??L H~?x?Xr???s~?^ܿ??????? ?1???????qz??w/[??դ7?o??9?Ur?FK??bb????BX?bֶ#`?q??b?G?@e?iu6??????J?p?G??Y???5EuS?b??c
8?????nN???j?d??0??q???x??D3	???J??:?ռJ{??+#@???ٔb?pT?$?!
?8?i?:?z?I?]??F?@t?<?}????=^<?Ç??????O?"?p&;?v?&%O?{?3c???/?)C?}??	"<d?ޖOX?Ԡ?o??yģ?????m??tɄA?????????/?h?T?M<??U?????2m??n1+TU?I?[??A~"P?? *?p9k??\.qb_???&????aM??t?D/?i?Gʆ_?C???s?>?j?!c??Ń%o)%-??2?r?1(<?L????sU.S? ???;%??I
q?jC60?8??????T%?+6?f??Z?????????1????Ζ??W???;?0;?-e??!??o?a??NqOS?>??Lt`3???58VY???56?uTT?Ⱦ?9??4???Q??$Q>TT8?y?l????X?7???U.???u???/'???(+yB??ٞ<??C?ڢ$ِ<<ő? ??i?ձ??q???դ?[_?????M 7Z???/?R?,???	???G?J?,??Z??`??p+?}?#?Cd??2`?|?Ԡ???D?J??Xb%??L?c???s-?vm5pN??F?	?1ą?u??z???S??By??i??ɤ? ???戆?i0X',+²?	?N???1,???&=ްu???an
F??xq????w??O@?Ӧ???t,p?????*{F??M??[D????vy*???{?;??e??B?a?J??O4ݞ?8??#,??2?????9|?Vf?ܦ1?!?˜???۷1F(??4"?8LhX>N?pk?v??G,o???5???????A_??[?i0}?D??Yk?׭?#o??w??????6?Yʃ?c܂?3H?	k?\?Mx0?g?ܳ????????BE!?w?f?F???L?gX?<?~?-?????
???K?-????cE O㓐Z?D??y??p?	6ѧ޼R??v?R?i6??PL	???7\S?%mi??&?l˷[u??~a?:,T-j??]D?+?}?o?]d?D??X???i5?ߥL??6MBB?gr{?X ??	???z?F?Z?9???p??OJ????0?????"%H֥$??eP?u?R2???L?VD??d\y?4?8?ɍ'????ƶ?B?k?;F??5H?&????g?????&h??	MvO?E?F?&?H???ї~?[)?p???_ ?4?S?L?ԅ???u?u啣?#?$~z?AK?@@??y?0-?&?2ݓKα?K?ܯ?ג??r??2?O?Z?
>?b?Y?2B??p?? g?_?a??"5.:?G?QC?b	ԹOJ?+?}??5??2I???aYb3?f	R\?}??:?V??8?????l??Y6/[????1M?*2$?uTo??Hx?G????_??)??[|¬pu?}6?????u??
Q?J??
?f??l??a A6?? ?ܶ\8+XJ??<$?*W?'?(&:f??wdΪM"???*z*?lIӼӖ?w&?P
??3Ŵ??u?6?-M6u??m|?,??M]???E?d?^ ?p=??ZB??';???p???ce?#????)˹???KS?=|&C?؞C???I?	i???!???a?!N????a)n?3
Ɉi?J?ゔ?ʳ?J?\?$:c?Ƹ?n?,?6?6C?M?ɛz?Tb8?yQʚgz??~E?B?\2?LQ'%9??#5Rh??z??E?M????f?X????q???q?p??[? N???f??????;pmz??? ٺ;q????A????e?j?w
??Nv?/\,%???w???IK>e?@?F?S?˵D(N???}?yqG%b?P?????o???e????B?q?
?\?R?f%0?????TW?.?)???T???b-??ˡ=2??A&L컉$?$}zh?y?Y??P?<?;???ДUz???g?d??|Y?q??M?468r????)?????i???y??ϔ<!2???Ɖ^}kP?T?R?I?2c?.>?R?K?????
??I??Ǉѵ:?7?Y??j
󰓱?;?C?!+ّ
?%v?&??
N??\???nUNa?I?>?????M??O?4?	??45???<.A??P???m[?V7?LSJ7?W?,??g??WI?|??W??I?Yn$??a??6??Ql?9?]????a?ר?w?S?5g?m?Ěa?????<?֜??X?c?D?5?y?B?IN??V?4;?7?E?xO?,)??L??????/?I??xC	0 n?cV?x?/X??LLp!??]?aRVx.:??R?Dg0ĩ???K E?e?)??????t?v?E7%Hۧ?su?@L????t??cݽ???C?G???1?J
8C??
o???c::?X???}?KE????ٶ?g?JX?4/&????!?kø?M?P.U4,-??]?d?I???(?8luX?,??!??(?P?%??Iz?7?3y?b??
*?h???!?L?\)\??:??????n??aM?׽9??{??{???<???`??*??R?-????????	a$q+!-.1$??J??????9???????0a??lA?????{?u??v??????BrU$??' ?*"!=?q=?Er?^37???p(*?3W?y?j?D??R:XG?]ߑS??zSL "?????t\G??<v?aK?0?%_???_?C⫡=e?J?d,PIRTDþЖ???ǅ??MMw`???dߗ??+?ӕ?P?T?5??ߊz唎oI?tM??b"????_)?i-?Z?I3???M"??#y7?zR???Ls(???ǘ?h|??ahETNƔ???x_???$???Z&?7?a???|?ȹ??8H?䦱?	q˺???͵?3Ew.؀˟8]?LR-?{w?=?	0R9?T%a?~S????VMa??????X0p?^?T+?	?I'*ֱT9gd???S?k????$???T?R???$`??ܵu	z???TL???[_???;?-??{??F]?7e`5|?+?|b;("?︟?a??ͼm\ִ??ɒ?|)Ydۙ??,?f????SKQG0]??D@?lC?-? t???rQ#?s?
??ɓϳt?)???X??&?j%բf??Z???$??4?/?}<`?I??~?>?B?J8???vmG??f??Ͱ}?5?12??{f?K-??D?9?_?I? ?ac????a?YM ?	?7??V8?8{?O???\)?R?dF?lXr?׈Ic??lsd΋*k?_5??)????D???y2T?E?q1J?/?n!ߐ޴L?????E???
?u;0"~?u?w;/??M????sr?q{Xm9%}?S2??)\??o1??    B7?&قo?3?WñTd????U$o?5Es???&?tD\d???KYV?3y	_??R?\?_????mfeh->a??i#?(*ۺx?w????i??????g%?3]$l??ז'??l?I?c??*낙;?I[?6R|CZ?X	?ۯ????????[?voV?kp)b?.>??>o?X?????k?!N?z?#?xJ4?Z?"??$, ?U??i
k??fOl??s?#F??4?? æG???fמ$?c8???w?`ƴ!?1??*?DΫ?eF@?? ?Ӂf?ʺ?h??p?+???iC?}xx???NkԤ??B?d?ف{Ǝƣ????e???????/?sS?A?Ė??4?;^?Ӿ??l߇?b?y?dj*+&q??nQ6???V|xqzӘ?k,????(G?'?I?"?R??Uߌ??????nV
??ߚ{?K?o,U?H?e?t??n?t?z]r???:w????!?J???z????@?????^ޒ??g???/?6??	?aW.??WQ??$n%&???6?R???ǘچ8#? ?I8v;?y???S),m/??K??????!	+??Mlr??R????"????0f>{GL2\??i&?O??6P??w??Q?g5k?NO@M???#?"?B????*M?vNґ?[s?FA1a??#
Յ5o?z??%?=n?(??? F???
?c??*?&ɭ?f?E?#4?F?!A?j??B???L?%_S?2?4o??b2?!l7?W?5?????s[?v??6U?????l hz?N??E?????n?ۆĞ?????,?K?^??0!?Tz??{?:? ?6?L?'??tܟ?Fʮ?l???*IfsY?5m?_?%v"????5?+7?'1???V?|??X?eT??Y"\?L|M???s?J%Jk?)?c@?Ԓ??J?????yo])?S????9lv?/??R???z??? pg??Y?????)??{Ӫ???vp?9?C?7s?<Ò?l??W??c?ڝ??"?$???a?oU???s???R?V??"?4??)V??7_?y?`3?@?<??[g#?k?KFW!d?l4@???@??Nn?_ܷ????»8k???^?6???Ç˂?E;??ރw?V??cgM???<#+????܆B???????&qr:	?͋g?0}b0???b?&?k?WuF?Ҭ?;`B?iuzRa?<????E??M?.}%)u?"?3????x?$[???W\>?J&?"??/????ZZ?%ʶt-??? ؼ??n>7?S	??\>QJ1KbE?????K???:?5????~??5???탊f[????f2???Ro:/??vFj??0p?p	???/L}??{Ң
{?TJ??ź?R?8m?j~??MXY?${&m?Kǉ?|????b??1˯Y
?^?????j??M?v??Vop?h??#??	Ǖ?<????YpYv??T1?????Rgb<1D????K[T??7??3lL?_? W4?ʬQ????ہ?ϕ_5@???%?M?!????????Qч???#?1?i?g??????򹹱*_Cs??j???c2Z??Nr+i????%K????`u? ????סf?ަ???[!jc?%???6?1?^)?IVմnȥ7)?????a"???+C<?????i???6??b??oxx?p??BÕ?"?dR{ܭ?w?K?;k{????>t???@
??OI?i????FWG?LX???8???F?f?kň?>=Q??}B]?Hd?N?4?Y?Û???K/a??Ҿ?n?T?-Ta'Xb?7]??NL_?B?@???x?X+|?f?"Z?i?\?܊?B?#!??tDρ?Ӆ?sl?}&`??M?QDBH3??gr?????$??~?l????[?<?[??'?P??Ԧi??G?"???(ܓN??'=g?4??????gEX?q??|?Y?b?|N??_?<???R??m??kP"?P?O?????Z?0]j?>??D???5??L??h?a?oOt?*'y???4??vYX"VW??Pz[&*?&1a5R?????*?3??;?4\Q?DZ???kb???? ??pS?/?W??K???2??;A@3Ͻ?????Y}?Vf(?1Y??Uy?X?TռgA_??e?a1??????ތ?_"??t??w????!Ǝ rZAw????1#}.?(?d? ?C%?Ezv:? ?Wv??N~?k???4+W;v?0?q	?77ٶpk?1~?B??|?N 訔k?襰=J0?L~T???qQQ?wʂ?Hĺo?x?`??????㽠'?v???.e????2?	?f????m?;ߤ???`Y?@L??"?&?
VBߕ??	??I?P*???J5)`6]&??l?n2s?0???(?RT??Uoc???ӅV?????}??4?F?q???S؆&lCSim??*??$??O???"??k?b?3?c?#?_tt??????̭?r~u??3??k??|p?O?u???#??l?:?e&}-\?$?.?Z?
??[^? ?چ7h??kƮ?U??c B`?V]wR!=???m????`?.??#f?ō?_P>?m??&?y8ñMi???BiwX??_?z????)?Vz???Uh?6F:Q? a??*Ŧ??J?6?.OX??D^??4	?HD??CV0O ???̥31?߶?????u?c+???][3g.?>!??1G??je????sM>?pv???{\5?z????qm??????R?0Ӣ??]jw??T',u?l?{A?o????^??8?s????e????J2???s?0	)k	?0۰W?pJ)JEV/??q\???哽??????3???????K????ը}?i8??Ʃ??#????L5??Y?_f???L??LG?ZtU!9????dqU0U.3?d\??Q\?͸,D??1w?v???,1?)DP?N?"b??@Ep??p?9?m?Dm?e?DB"?@???
??bի/^?ٕj?Ea?6?8ϵ??????k?<?u?jub???_[[??t:????????,o??ӡ`??b <?RӠ?(????(3HDlq?2??=?Še&>???lO??????[????޷m?40Y:J?m?;X?J*????
?-wEn!?̴і??Bv?q?????_U{?<??&"?1=kխ??q>??I`?/p?ua??????ԑ	"{f<|?5?%5T?????|????4?Q??C?6}???????@??#??)?="ҋʣ.?E???"3??hݦ?IͲr????? ??Dw???T?_H??~?? ??R%?CKv??ƿ:_ae?%\?ra?????Fմ????|?Y$?;QQ 	??~~?lZ?zd?cJ ??*l?-gY:Dd?jN??I??????????o??/??P?jIi?X?????i?????E?0????'?y?%??Cz????v.???????i/p?2??*?Z?I???ND8?\??4W??s&җ???s???a???$?BS?Q???yS?Z??e.??}:SVx$???r@Ӕ?h"v??\?? ?#??2v?h?d)??x	?b???Jl8VS*S????b2??]?n?S?X????YŌ̤?%?v?q?;	??W?????F:??????x?а?!Ap?V??=>vt.u?Lt?U4???T??N??ҩ?ej?b?U?.??$s?]Y?t?aVf??0.p??F_?!N?md??i⇚????8&?d?s?dKE????????%?73??2?C?????Ie??],??Qg)??͓ڳ??TU?q2?fפC?U\[!I??Ň??^?7???R]?Z???;Vc?????Ah{???Lj???'IE?`7?????ۖ??/?no?|6	??Y:	G!?~w?ʇU??=Qf?z??5?@R??????uɵ??-?Q?iœc??H2I?Z?,KC?C?L?<???<?(??????????p???+z7?>{?~??\????__z?ak??c?????=m?ٻ:?I}9v?#?X#?????R????&h?V???k?i??GcjOf?H'??q??[<x?JU{??. ??ĔR???%??7?k?,?s?,?s??^?N?BtX??V^???T?y???+????:???,?u?/?]v?p~HH???G8S??{زBI???    ??????Z?S??dcD?vN:?-?????bŪ+??b??O-???F0?%?$??H l	??Y"?O???'???м???Z??72 [?)?Q?????-?O?b?b?r?qӹ?U?BEI?p,?Bp?59?@i0)3Y`?
?j??':CH'??0?Z??T??2?Q?jK???Y?*?m?a6??,??'????$??"?.q???}T?{?7`????6??5??????e?????cx?2\E?w? ?8oI?n??߁QHE???????*R??HĦtg???Zz?q?X%?QXZ????????P???w"mM????M?Ȇ???U?0???#?y??7"̒/MN??iY??a3|ǉdU
??7????u[?a?./?;GHx?0????z?? }
ֶ??"?<?4b?Lc??)????????2?^???g,=??ӗ?????\?v?????x??mn+L?? JG??ZC?????W?M:ۚג["? ??-?'K^a??????P???????o$)*?e?@=?(???h?Q????Y?????b?鈜?$4=????LI????^?qL	?bb.Ω?z?'*????])?Iz???
?V,t??d	?Γe??W??u?W????Rd????ԍ4ٔ?-?????S??2=f?<????Ax??v?"?=?dy?It?c/????7ᮅ???*_?鏬???????\Ύ??j8?i:???o?Wۡ?<?? Ol?a?.???dt?_KlŚ??[DbG2??칗??g?H?Wh???crL?r9ꨊ"$\???W&?????m?l<c,?[?9F{1??peM?<J?\/=??2????!a??<?4?s-dF??4?zC??OL5? eG??g??No?~'???u???s?%?R??]?sK??`9[؄?ϟؚ??????lѮ???Fx?%??Q?
F?????؍o??&?	+@"?QT?)?%Px????R?s?c??J??r?J???a?r??????ϑܽɶ:??;6??B????Ҝ???Eҧ??s35N??\? i?'|?p?xO?Ө?%YZ?Q>l??S}?^??cu??v?٤?$?/n?P?Z-?	?Sir
?Y?R?6?i-???5??ߩ??UE?C?`???T2?Ra?V$ ?yV)???6?B?:Q??c??v??Bp?P???OZ?%?%36????M?
???:?@????M????>h"?n??B?fp?G???u???I??96??????#٘%??ץ?\?}ÚeF*	3?91Ғ?\l?Yu??ڦKiL???V>>~?-:j?a?^㞝???5sdD?$??ғ?M?fJ????"9?ϙW2????j??3??????^????b???}????K?5o??jV/2??????e???̢d)???o?%????^??:?ݻ?، _#g ??A??PB?GU7#?"T??
?? ?Seԯ???ܫ??v?/?Oӳ??S?q??sW&,(XNPS%:?xf&ٜ?!?UI???B,׹?3??i?U????????h}t?©)??? ۀ??Ta[Y?m?41?*??X?yf??4?`??]73?{J0??q?`?%vw??2?폄0;R,UT8????h^?W??)?8??o`hE?[7o?aZ0n˘#?????8?G???(?_?^?}"*ҕ??m??[???#?ja?U|S??JfE??eϫ1;?&?Dg?????%?5?IjI[??%???fH?Q7??0??+F???)?????_F????Np?
T,L?F???Z'?I7x=?????^??|?D3J_5??? ?7|D!?????Ѣ8WK8nĪ-s??~???k?u?q?S???5k????&?>J?
??@??o?&??f:/?H(??P??~M??5\??gl?/?4=?R/n^?QԛΊǋ˕?p>{?v?7;??o???S=?S$ZXf?z%M?wS???]`e!q/8?p??3?M???OG??V'???????2??D???O?WIB?h??88,???;'???5#?Xm2???@/Js??`??9??w???FZ\w????ۛ??Lthr?5@?tSw?[ ^?i;_?R?XХZ)Wؙa`??qH??,??Lf{????XyI?P3???????oN?,?0??I???:|?
??Q-???l??D\H
?9?a?+?????Q??b?|!??-(0??CcD?#0/7????{?RaV??](H???;??a?HS?J?F??>vn???Oe???}+??Lt??Ղ{@mD8Z??`S?'b)CxR??V???N;??4?:??i?l?h??Q?0ޔR4^}D??r?h???t?.?|?i?7K????#??
ʰ=:???a?R4??-???2?o?K?J?$?'6??B=?kR*???]Tþ???b;??r8*?_???ѧ?o?M???xu	&?4???9?c??NIM݋??????_2??r???VC?0?XUdj*
-??e???$"??>kf?%qya??<k?D?t,???E??"?0%cY??N>?ٓ?"bþ?Y?Ѝ?VB?/E?ְ=??~H}S?jbۏ'T?0]?һ/??hc??^?q????V'钉ʪW?c??D-W??????E#8?©??f]????n???????x		?Io]n?K-??SE5???8?T:??F???dD?7??}|?P?m???q?\/M?i?? ?z8?)???_6?[?Al?0?|???2???s#?7}?psr+?%,"?oN?ܛ'7?3H??}?de
?wX????#s
M?K?Ķ????`???b?`~[????????e+&k??9"m!??s???0???s ~??R쫫??{?8-???AZn?z0n>v?b֗????E1?])????d??"?V?????Ԓ?߮?Xs?DE??x??y?Q??ڽ:???hȳؠu?@ǝRH?2??ڦ?W?[ҳ??4+?.D?J???J*H??[5?<???~f?????wox??5<?xwݛ??Uտ?l??ThG\??T????0)I3XFA?"0?.?ӒΈM?;??7RL,?a?QTe?????s?jҜ?.??6??M???e8?Q3	?1?c5?H?bk?XIX?~??? g??.?????q硬5???I?Ra??֗O&?r2?6zwv?.?رt2&Z*Rg?-5???ҕ??	?f?.?ؒ?45??-??U?k??J43?D~.?V ????4???ڛ????v???ws??e?*M???4}D????L#??S+???&??#(,?eR???~?;???a{?[?9<%d?}?*)????*????(D???ȒQ?t?k'????RU?????l?x
#?D?-%?_)ϱoG榦<??G?|?????;X3??jQ??RD?????i????????????g ??6????i????jU%??+???
~??J?ۦ?Z"???d???$?u??#???A???l07?L??XF????%3'd????}?ޤI???#x?u_G?o???D?l??uT?>X%??MI?u?zø?ĒZWs?R'e?GR,???QU𻌆??0?[F?ɯ???|K?aBf?B?s?q???HJ?5?B?_2FZƥ?.??*?Q???8>?????:+z?&6??????}???O?Hѵ??;+??I!lD??l?3Ue???F???Z?z??^Wxz?uNW??`??oeH8p???>\?,?f"????(MWz_??'	1?܌!???y?_,Љ???@[$;?27?+B??V?^???* ?#?Yh=??qх??~E/֛?Zpx?,J?q???$?[-ctL?㸱cr????1?d?9?????y?l"??g???2-??aK???vR?p??S?/w?dS[??щ
̀a?|?Ҵ?#??_?6?4?úI??֡?e???zY~`u???i8¥?9U`=?i?4W2?p?Fa??p?'vʃaw?3???+S6?P?¢??jBS????0?˱?X?m?tD?1g@Ib>ٷȍuܭ???2?a?ӮvT-??0?5u/??>??Hv???ٹ??u?A4??'r?l?ى?
??.?`?? &W'K?????|???6z??    ?????Kb2DY"(ʖ??P?kod0??U? di 0?f*??S8?a|{???O??d?i??)???Wն??????G?????x????7N?
47??P???????}????%4?TV
6nD?N2)??F.???65b?k2?B^?,̸??0Qv?l?T-?ʀ???o@??fx??p?z??r??A?!?q????#&X~AH搕r?.ʽh??U{/?_??ÿm???E??w??L:??N?җ>?????k9??Ws???~?a`??H?ʹ?3/)?I?m5}?q?T???_W??L???X?ߚ?dj̳$z?.)0?<?U[??\??^ݼ???Lw	[)/T???????r??	ÑĹs%?}??I??b???`a?	?ޞ??r??Flu?%?O+?K?k?A5?x?M???H????W?f???V??x#,]?????~?_??c?~ׯ?ك%e
iUC?"???????ț ?4??A?jɔ?ܽSQ??Vʍո?k=.Õ??<?k-è.?҆?͓i?;wX??¬}K??(F??n??8?<J???U?4?;?c>??n???w#?[??eO??X6?U1*6?Zp???#?eo?u?vj??T?x?w?;?C3??Hʦ o?55̓?0?HƊ?|~kR"?D??b? ?A?????1&?)??Ζ7?΁gRf݈l??y?4??;??L§bɶƨ??,'????f?d?Ցd7"??6 R?=%)????睒	9{??ʄ`R??????+?????'?fp?o??Gx???{????UG?i?m^???????o=??\
Q???[????\GT[-?t??'bj???/ex?k2b5???|(S??Z[?(6??y???q?0????M??"}"?L??j?)X?O%?8?Z???=?6?ٙ?լ?z?8?????yx䜽P]????u[???\??o?ڻi<?f?VU?????ˏ}???̕?M&0d?of?e+z???LBO??vZ03???~8???Z??D????@W?dC\˗	. ?Z???r??g?F?^n?????L?,J?A??¼?<$??>?8}??78RfWAa?V?t?6??6?g?dl3??l?S??9??:????\?bY?*?z???3???|?>(?I?	??XU???????4??G????R$u	??c?=w??£(????[q$R?t???Y?O0??d??K???pz??Ka??d?e??]???`2?J.?????R??*P{T??????ϒ??~Y??4[???(Rj??YW?oQ??m!?J?D-BJ?O?????????X??%e?j?v???P[??L??b=??Ѹ?????4?,?׳??ֱ??˹?3 ????j?/+??IJ&??a?D?t`?T̔>???2z??7?S?_Ն??'?[??ֆVF?g? ??? L}??I??T7?N^[??tRfԱNE??O?N[/k?J????ݳV???rxL?S$zUBcBɁ?T?R+F(?P?݁6?٫?o,??????L??j*v?hد??X??2???23<J'??]Z????g?*???????Y??7?=Cj&?K؝1??יQ?N?u?JhVR+}
4O?|?$??/S??W??`d???O?~\\6??!??e???:-ozߨ+{5iwo?6RV>??tB???9??+?{!,/??[?`?9G|??r?Ig?!?t?)??M??؈??2:W#&b?d!?(???8jl??'??ct?
?ȳ?(?<??Dp6 =?6܎???_ˢd$?hy?????R?8e]?????????j???b??.-???kd?\?.G??d
8?y!V??dQ?1?AfΫL?Q?+ӼV?N??[S?E@?4?J?A??J?P???}cT???:)?F7DT̜?l?????LW%rEjI???t<?뺚-"?Cؘ?:;??d????ٖy???f?????>??;??f??x?&)u? ?Mn???TRk?*ÚJ?2?ʹ
3kЊ???ϵ??ZE1?Lef/**?%_??_KI???	~???R??֞D?)?
?f????I?J????FӘ?ã?̪??Y}#???9?HV??a?L???oj??R?BZ^?_K???J?O?Pr\????iӿ6P??.?s?‍4?????+???٧8+!/?!9??M??VDfʕ#?'??j?Q?c?C4˘?ĕR?xW}*??3??Y^%?`yX?0}q?(sb ?L?>ꂏpp2??Ίǩ???Z?*?LB??"???????RZ??;Hí?B????<>>?FkF??r??~6C}???'???? ;f?)?r*	?\??????`٭xC[i3s??v,-???ѥz5?ҍ?-?N??r???I??p5??.z?Ih??g??vc?8??v????{????GM#?????Z?]??O?bï??O? }ұ?
X?p??!ꚣ???yp??9'?T43LZt:Mt?|)??Mki6? ??8͛?վ???m??_&???;??X???I[ې%.9?ZZneΆz3?-??u?z????Y1\ES?' \hF????kJ#??%?Y??w??M? XDl?V?????vz?V?d5????P?????sr7?^FAgn?9??7?a/?????:9?v??-?p?}?%Y?H?1?N}?xb?܈?٢??R?W?K1??]V??uܮ??Ó?p	?x=?X??G,?p5n^?\M#^?bSp??????x?UJ$???n???5?9???l? 9?????01K;r?Yɤ?LH???h??㬤??o8~??????-~?PQ>_?26`I?M~Z?_e?u?h?????C?^??o?)?[?w9??y???n}???p???@?C|??=??)???n???s?>R??'#??"?9r?B???X3???8??qQ.E?V???*?o???)?m??F?^w?,???a?7ݽ?4+??܌?)$?eML??S-?Z-?p?B?#??v?J?״???,n(?xe&?Y??;V?{??Ζ?????v?F?	?'+D>?7???l??7/????
E?-??$??'I??3????l?(??/J|M??? ????????ab????uX?U1????Aq(\?d????bn?u3M?20ř?1_h#b?͌?J??Li0Ӗ??-J??H????ߪ?(????	?=s#@ntX壬;???M(?:??෻n?:ɌzG?+?[?GO.???q ?ҙ*?C?6ũ?Q??8,1+I*??
??W??d?n?I,-??v?q꯼?????+???)??c?o?<?/??<j kE8o?{?S?????3??V??)?N>??\??
B??ѳ?R??Hk#?",TJmB??T???#"p?r?ÄY?7$"??ZUZ??-?ٻ/y?x????^????4?'??jK*Y?j?M??j&p_f?QդT?????x5?g?.?3Ys????m?4??????s-8??O"?????/??%acu???5?W???????Q-?? L?׌?<???A?dO6??iF,?w?*?%?h????3?3??'??-fJҥ?b.?iR#????pbi8]??M?E????	n??mJ?q&?c??H?ӆv???9??/NOf????????K/?U???g???)eR??1;?4z?_T??|?a/?????9?w??b?֓????????	?cmd-?c??*<??k?	uz?yX??1^?????0)ns@?<l:??%U??L?x?I???????D??b?m??????ٻ?=>\?z?3]????????|ϗ??0>5D?ggS:I1?????P?PүUwM????
??p?	e?_?&?2"Y?x???????Fz???y?}
?`????V]s?k:َ?????$??k?y??$?r?}"??̵(?,z]?9\]"P??<r??ðŉBn?^. ?,?/{?/;???Qy?H?c|???2a3?IZ???ŜL?ŉQ??eq?D-?	?ѱ29?FnřPОe@I?E?\???G??6a>"?)*n?"?)??oY??&??x0?????L?޵?~RA?.J?%Q>??_f?d??1F7{?3?ɵk???e???f??????a*c;?'1?o5?????LwF????2j?R??L?w?1?u?;Y?t????$?av? ?	  ?h??E???Oze??}??ǒ>.I߽????/ʩ??9?X?R?`g*F??ȫ??}??TTm#ڳWu/Yg,?G$?j?D$-?k&vz?ݓ????kyM/?1?u?E/?l?????7\???M??????.???????t??̆rM~9?$JH?Kw?ZiyN?Jd???;?,???atL???~?眏񢶍?$????W?????Վ-??n2C??b?g??????Xf?BI??:?w???2zVI??a|???7?`ՁI???$QVg+???ppY?/z3o?#f'???8??߁f?)[Pu???N?Zk??ᔑP?ފ	Sr??&hý盛T?J???Ea??N??bI??Yכֿw"3U
?K?RA?????[s-q#p?N~3̵?/W?ʬ ???Nk??ҚIF?]W<	%b?,?S==??????!?fp?׺Y?ewn#????h?ÔgG??x	??1????^W??O???????s. a?П????w%y?#??{k??#3??/??߹Swz?E?|K????Y?Y??##Ul??? ??pe?K??2p??<?W!??????Й?-q+?K?n'p??4mO?k???,{???k]?7u5?}?z/??S?;,?pۭ???;knv{S??+ \???~????#ɝohg[??u??ׄ9i??*-?pݜ?lE?_s??stUzf??+??;?"???-??ވ4???'??V??8	??x#?????3??x&?`?|???2ܑ%04?wlM?l??`y? rZ1??$?[?-??????????fd!?????ogn?????ݕCF?ov??Ft?p?[{b?>;?sH???i??u?:??D2*??fU????.?Pe?ٍL-L3????kV?ɥ?n???ً!\j?~<r͍???۱????Mx?f????????ڔ]Z??x?:[x?s!??5???M?1??z??&wo?N?Q????2?[?o?r]??0p*h|G?A搚?5????y????D????M4B?Q?S?I38?7?????T?(?????LP?{????!)?g?cܛxRλ?C????+??4??<|?????;?N???*K?????Q6$|+G$r??,?ѹ????Y??ݥ??{???ڄ??F8??u*%B=??f?PF6?\?a??????F[z4??e?DD???R? MC???dx?JF?*?Hɜ?k?K?]Nu?D?!?(DKym???v{??h?;"???h??/?6?1JM???z0n?7?p5l>^???{7;A??????[e?'?'EkJ(??????J???I?t?F?I?9??\?>s?NȊ??/?W?en??˜	?Xn?=?Z???8?;3??#?D??t?:k?l?Mzv?SsQ??zC???|?}<^Z?J???.X??{??4K????z0??.k??p?crʚ??f ?߁??_?L??i??NĤ??
??2?7?^??f{2CR???3?T?ү:??7S?b? ?8#rK?,/ٝ+9@H?m???.?T}??Y*??󆥛l?P?fR???W.?ܓ5?
d?fZ?FM[????'2??*c???8?2E?i?]#?IGŏ?yԛa? ??D?獵?|?ܕ?wB? ??J??Б??f??:>?H?%ǉ?Q??J$M????W??q?4?HF"?$??v&??R_????F#Q????4???#?0V?xj????V?
?g??;F<?=??d????:~??UgGڸ #?ZU?m??̈́?r?????&̦v?UF??L}?DEz??
ݡ?k ?BA?`N#k&???ZM??&????T??N?j3y}?l??1?Ԩ??<?$???z??Jڭ?想?1??j????'?@?g?!9???4|?%??????Ը???????	j??Ą??"?4St?QHV???{2)]??v?75!??i5vt%:?๝4+=?@?&,??jn"???%?`???q??+?S?8l޲O?hw?ܕ?r??2c????e???R???>????R?a???b?<ɠ?#]*???E+??5? ?Z????!oқ??????Q?*?`??ZӪ??? ? g[H??7E?˽3??? ??Zn???o?O?z???????dl.c?G??{c??????>?pEd쇎S????~???F?#??wg	? ?S?`cG@?b? [?a(nZ???!???Zw???_?D,V?(X???G???u?{??4??Ѷ>U+??4?蝇R?x?""??q?????yX??%??b|J???`?R?k?lV?(?pn'%?:???Hm?773??J?o.????$o???ۧU?????D
S?????ne`݋p?kť???ub??????T?;??)Y?d!Br9'??:?nZO?r?v?N?
A '4??C??$??Ԕ|?B??9?	@g??)??qy?X????ѪIB2?#?E_+??z??Џ6??f?3cB?|???`??}nz]f?z?> ?Ww????????????k4         ?  x?%?[?%!D????(??????:本??K?(??H?_??????Ư??w?? ?????(???Z?????{\???F???o?n???xO??13b?Q???h'????6????`SX??Ub????Ł?W??`?*?lšt?^%?l??k+?>??
??3?G?????&?^? ?r?ɨNͥ?{+9??"?????N{??M?w(g{K???b?b?}?(֏K??w8J&?Z???E???[C?ڪ ?o??z?}??MZ[????m?:?e?mctq?=?(J?8&??~??ܘ<&?V? ????r??(O;????J?	?	v??q????D?	c;X??+8?b??߮?%?]L?μS?Ll??]JVl%??ԉ{???|?????!???$?????Įn?g?u???kC?&YX"?f ?????͜-P??p??{?n?O ?eD7?9???Ƽ?s??vF8-2? W o?(s? ?s??G????}sln????s\.??q?-@tW??????_????yw???w?)?z?G?~??d?9??G>-?@Ǔ???K???W??? ???.[?m??ؼ??T?-U?]?h.??	o??{}e??Z"?v?????gA??xB??x²?%<Y51???????J?!?~>???tnK??v? ʱ??!??M?:*t??!ގ?0O??=????{V  ƭ?????۩??o?,??.???tG??
(?pp??.???;ܩ?pp?y?*?<y? ??,?Dt<W????????S(????mz*???????q(z???"????'?o?????+P???ɤ#??E3????1?u??p?~?C?????|???gd	?Go???n<????(?.@??a(????7???;sgV???y??dH??8Go????8??????? Ko܇? mAӛ?C?{????ii????n??? ?Ib?z??|q??O????Vw???t?;?]??|????`˪??ڍ??C??*?? 6?O?6???ks܌????0??\@??kwF?[????7̻?2??>h?pix?iտ;8R)AO??o??a7E???[????qۨ???ah???R???/?n???{?]?P??2i??;N+T^l???^??M|*?u3?i??h?+]?} K?>]?s?+?6r????ȼ?<+s?_vcB???t/?4k˄ڕ_?TηY? ??G??6+?wP???Βd?????h?nl?F?????*????^ij-z????O??%???????m???O??{ܪ?g?j???v???o?+t??$M?.?L???p???t?yR?????ޢdG?RT?Ʋ??䉽D???q?????|&o q??A+k???mҎ?%`&?? 3?`?ve?)e?????N?A?h??=???3c??????=]???~?n?n?, B????_k??$? z     