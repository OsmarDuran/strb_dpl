let map;

function initMap() {
    map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 18.859091, lng: -97.0971282 },
    zoom: 14,
    styles: [
        { elementType: "geometry", stylers: [{ color: "#242f3e" }] },
        { elementType: "labels.text.stroke", stylers: [{ color: "#242f3e" }] },
        { elementType: "labels.text.fill", stylers: [{ color: "#746855" }] },
        {
          featureType: "administrative.locality",
          elementType: "labels.text.fill",
          stylers: [{ color: "#d59563" }],
        },
        {
          featureType: "poi",
          elementType: "labels.text.fill",
          stylers: [{ color: "#d59563" }],
        },
        {
          featureType: "poi.park",
          elementType: "geometry",
          stylers: [{ color: "#263c3f" }],
        },
        {
          featureType: "poi.park",
          elementType: "labels.text.fill",
          stylers: [{ color: "#6b9a76" }],
        },
        {
          featureType: "road",
          elementType: "geometry",
          stylers: [{ color: "#38414e" }],
        },
        {
          featureType: "road",
          elementType: "geometry.stroke",
          stylers: [{ color: "#212a37" }],
        },
        {
          featureType: "road",
          elementType: "labels.text.fill",
          stylers: [{ color: "#9ca5b3" }],
        },
        {
          featureType: "road.highway",
          elementType: "geometry",
          stylers: [{ color: "#746855" }],
        },
        {
          featureType: "road.highway",
          elementType: "geometry.stroke",
          stylers: [{ color: "#1f2835" }],
        },
        {
          featureType: "road.highway",
          elementType: "labels.text.fill",
          stylers: [{ color: "#f3d19c" }],
        },
        {
          featureType: "transit",
          elementType: "geometry",
          stylers: [{ color: "#2f3948" }],
        },
        {
          featureType: "transit.station",
          elementType: "labels.text.fill",
          stylers: [{ color: "#d59563" }],
        },
        {
          featureType: "water",
          elementType: "geometry",
          stylers: [{ color: "#17263c" }],
        },
        {
          featureType: "water",
          elementType: "labels.text.fill",
          stylers: [{ color: "#515c6d" }],
        },
        {
          featureType: "water",
          elementType: "labels.text.stroke",
          stylers: [{ color: "#17263c" }],
        },
      ],
    });

    const flightPlanCoordinatesColon = [
        { lat: 18.850231, lng: -97.112862 },
        { lat: 18.848509, lng: -97.112689 },
        { lat: 18.847979, lng: -97.112896 },
        { lat: 18.847853, lng: -97.112910 },
        { lat: 18.847004, lng: -97.112618 },
        { lat: 18.847726, lng: -97.110387 },

        { lat: 18.846919, lng: -97.110089 },    //Nte.11
        { lat: 18.845998, lng: -97.109668 },
        { lat: 18.846009, lng: -97.109624 },
        { lat: 18.846919, lng: -97.110038 },    //Nte.11

        { lat: 18.847230, lng: -97.109124 },    //Sur 8
        { lat: 18.846313, lng: -97.108745 },
        { lat: 18.846346, lng: -97.108697 },
        { lat: 18.847227, lng: -97.109062 },    //Sur 8

        { lat: 18.847522, lng: -97.108166 },
        { lat: 18.848130, lng: -97.106266 },
        { lat: 18.847341, lng: -97.105989 },
        { lat: 18.847360, lng: -97.105941 },
        { lat: 18.848148, lng: -97.106211 },  //Sur 2

        { lat: 18.848420, lng: -97.105328 },
        { lat: 18.848687, lng: -97.104446 },
        { lat: 18.847889, lng: -97.104199 },
        { lat: 18.847897, lng: -97.104144 },
        { lat: 18.848707, lng: -97.104386 },  //Sur 3

        { lat: 18.848941, lng: -97.103575 },
        { lat: 18.848150, lng: -97.103333 },
        { lat: 18.848160, lng: -97.103276 },
        { lat: 18.848948, lng: -97.103525 },  //Sur 5

        { lat: 18.849208, lng: -97.102715 },
        { lat: 18.848393, lng: -97.102524 },
        { lat: 18.848418, lng: -97.102440 },
        { lat: 18.849220, lng: -97.102655 },  //Sur 6

        { lat: 18.849436, lng: -97.101833 },
        { lat: 18.848651, lng: -97.101587 },
        { lat: 18.848675, lng: -97.101526 },
        { lat: 18.849491, lng: -97.101761 },  //Sur 9

        { lat: 18.849772, lng: -97.100781 },
        { lat: 18.848958, lng: -97.100508 },
        { lat: 18.848984, lng: -97.100461 },
        { lat: 18.849794, lng: -97.100726 },  //Sur 11

        { lat: 18.850097, lng: -97.099726 },
        { lat: 18.849267, lng: -97.099522 },
        { lat: 18.849277, lng: -97.099433 },
        { lat: 18.850110, lng: -97.099642 },  //Sur 13

        { lat: 18.850424, lng: -97.098623 },
        { lat: 18.849544, lng: -97.098414 },
        { lat: 18.849566, lng: -97.098337 },
        { lat: 18.850448, lng: -97.098534 },  //Sur 15

        { lat: 18.850673, lng: -97.097846 },
        { lat: 18.849795, lng: -97.097541 },
        { lat: 18.849830, lng: -97.097484 },
        { lat: 18.850691, lng: -97.097784 },  //Sur 17

        { lat: 18.851031, lng: -97.096756 },
        { lat: 18.850158, lng: -97.096451 },
        { lat: 18.850171, lng: -97.096380 },
        { lat: 18.851031, lng: -97.096692 },  //Sur 19

        { lat: 18.851383, lng: -97.095667 },
        { lat: 18.851657, lng: -97.094674 },
        { lat: 18.850820, lng: -97.094349 },  //Sur 23
    ];

    const flightPlanCoordinatesOriente2 = [
        { lat: 18.847010, lng: -97.112544 },
        { lat: 18.845190, lng: -97.111948 },  //Cri cri

        { lat: 18.845667, lng: -97.110475 },
        { lat: 18.844862, lng: -97.110156 },
        { lat: 18.844878, lng: -97.110118 },
        { lat: 18.845684, lng: -97.110434 },  //Sur 12

        { lat: 18.845951, lng: -97.109646 },
        { lat: 18.845180, lng: -97.109318 },
        { lat: 18.845196, lng: -97.109276 },
        { lat: 18.845965, lng: -97.109603 },  //Sur 10

        { lat: 18.846273, lng: -97.108724 },
        { lat: 18.845516, lng: -97.108390 },
        { lat: 18.845531, lng: -97.108352 },
        { lat: 18.846287, lng: -97.108679 },  //Sur 8

        { lat: 18.846546, lng: -97.107980 },
        { lat: 18.846783, lng: -97.107242 },
        { lat: 18.846893, lng: -97.106879 },
        { lat: 18.846217, lng: -97.106634 },
        { lat: 18.846230, lng: -97.106597 },
        { lat: 18.846906, lng: -97.106842 },  //Sur 4

        { lat: 18.847118, lng: -97.106455 },
        { lat: 18.847295, lng: -97.105969 },
        { lat: 18.846468, lng: -97.105695 },
        { lat: 18.846484, lng: -97.105663 },
        { lat: 18.847305, lng: -97.105925 },  //Sur 2

        { lat: 18.847831, lng: -97.104168 },
        { lat: 18.847051, lng: -97.103924 },
        { lat: 18.847066, lng: -97.103883 },
        { lat: 18.847840, lng: -97.104125 },  //Sur 3

        { lat: 18.848091, lng: -97.103302 },
        { lat: 18.847306, lng: -97.103049 },
        { lat: 18.847325, lng: -97.103008 },
        { lat: 18.848100, lng: -97.103258 },  //Sur 5

        { lat: 18.848347, lng: -97.102484 },
        { lat: 18.847602, lng: -97.102222 },
        { lat: 18.847624, lng: -97.102172 },
        { lat: 18.848357, lng: -97.102429 },  //Sur 7

        { lat: 18.848606, lng: -97.101556 },
        { lat: 18.847927, lng: -97.101331 },
        { lat: 18.847946, lng: -97.101287 },
        { lat: 18.848613, lng: -97.101495 },  //Sur 9

        { lat: 18.848895, lng: -97.100558 },
        { lat: 18.848219, lng: -97.100325 },
        { lat: 18.848232, lng: -97.100290 },
        { lat: 18.848907, lng: -97.100520 },  //Sur 11

        { lat: 18.849198, lng: -97.099493 },
        { lat: 18.848855, lng: -97.099407 },
        { lat: 18.848520, lng: -97.099346 },
        { lat: 18.848534, lng: -97.099301 },
        { lat: 18.848854, lng: -97.099356 },
        { lat: 18.849209, lng: -97.099444 },  // Sur 13

        { lat: 18.849494, lng: -97.098386 },
        { lat: 18.848848, lng: -97.098209 },
        { lat: 18.848863, lng: -97.098163 },
        { lat: 18.849511, lng: -97.098340 },  //Sur 15

        { lat: 18.849769, lng: -97.097516 },
        { lat: 18.849133, lng: -97.097260 },
        { lat: 18.849150, lng: -97.097224 },
        { lat: 18.849777, lng: -97.097472 },  //Sur 17

        { lat: 18.850103, lng: -97.096416 },
        { lat: 18.849502, lng: -97.096208 },
        { lat: 18.849517, lng: -97.096168 },
        { lat: 18.850111, lng: -97.096376 },  //Sur 19

        { lat: 18.850376, lng: -97.095535 },
        { lat: 18.849757, lng: -97.095321 },
        { lat: 18.849770, lng: -97.095285 },
        { lat: 18.850386, lng: -97.095495 },  //Sur 21

        { lat: 18.850752, lng: -97.094292 },
        { lat: 18.850228, lng: -97.094030 },  //Sur 23
    ];

    const flightPlanCoordinatesOriente3 = [
        { lat: 18.850200, lng: -97.112773 },
        { lat: 18.848461, lng: -97.112624 },
        { lat: 18.847906, lng: -97.112819 },
        { lat: 18.847071, lng: -97.112537 },
        { lat: 18.847760, lng: -97.110416 },
        { lat: 18.846964, lng: -97.110107 },
        { lat: 18.846988, lng: -97.110041 },
        { lat: 18.847734, lng: -97.110333 },

        { lat: 18.848032, lng: -97.109495 },
        { lat: 18.847294, lng: -97.109156 },
        { lat: 18.847318, lng: -97.109101 },
        { lat: 18.848064, lng: -97.109423 },  //Nte 19

        { lat: 18.848360, lng: -97.108493 },
        { lat: 18.847575, lng: -97.108223 },
        { lat: 18.847603, lng: -97.108154 },
        { lat: 18.848378, lng: -97.108439 },  //Nte 7

        { lat: 18.848716, lng: -97.107409 },
        { lat: 18.848996, lng: -97.106533 },
        { lat: 18.848183, lng: -97.106283 },
        { lat: 18.848210, lng: -97.106231 },
        { lat: 18.849011, lng: -97.106481 },  //Nte.3

        { lat: 18.849256, lng: -97.105591 },
        { lat: 18.848419, lng: -97.105334 },
        { lat: 18.848699, lng: -97.104397 },
        { lat: 18.849185, lng: -97.104568 },
        { lat: 18.849508, lng: -97.104483 },
        { lat: 18.849599, lng: -97.104511 },  //Ote 3

        { lat: 18.849801, lng: -97.103880 },
        { lat: 18.849008, lng: -97.103604 },
        { lat: 18.849030, lng: -97.103547 },
        { lat: 18.849810, lng: -97.103833 },  //Nte 4

        { lat: 18.850055, lng: -97.103007 },
        { lat: 18.849254, lng: -97.102746 },
        { lat: 18.849283, lng: -97.102669 },
        { lat: 18.850056, lng: -97.102938 },  // Nte 6

        { lat: 18.850310, lng: -97.102138 },
        { lat: 18.849541, lng: -97.101863 },
        { lat: 18.849551, lng: -97.101768 },
        { lat: 18.850338, lng: -97.102060 },  // Nte 8

        { lat: 18.850683, lng: -97.101084 },
        { lat: 18.849838, lng: -97.100797 },
        { lat: 18.849859, lng: -97.100750 },
        { lat: 18.850697, lng: -97.101023 },  //Nte 10

        { lat: 18.850997, lng: -97.099985 },
        { lat: 18.850168, lng: -97.099755 },
        { lat: 18.850189, lng: -97.099663 },
        { lat: 18.851032, lng: -97.099915 },  //Nte 12

        { lat: 18.851368, lng: -97.098873 },
        { lat: 18.850498, lng: -97.098639 },
        { lat: 18.850533, lng: -97.098552 },
        { lat: 18.851394, lng: -97.098785 },  //Nte 14

        { lat: 18.851616, lng: -97.098127 },
        { lat: 18.850753, lng: -97.097865 },
        { lat: 18.850768, lng: -97.097808 },
        { lat: 18.851631, lng: -97.098073 },  //Nte 16

        { lat: 18.851963, lng: -97.097110 },
        { lat: 18.851090, lng: -97.096787 },
        { lat: 18.851107, lng: -97.096725 },
        { lat: 18.851973, lng: -97.097054 },  //Nte 18

        { lat: 18.852587, lng: -97.095063 },
        { lat: 18.851734, lng: -97.094695 },  //Nte 22
    ];

    const flightPlanCoordinatesOriente4 = [
        { lat: 18.846994, lng: -97.112588 },
        { lat: 18.845174, lng: -97.112002 },  // Av Cri cri

        { lat: 18.845069, lng: -97.112335 },
        { lat: 18.844582, lng: -97.112460 },
        { lat: 18.844273, lng: -97.112421 },
        { lat: 18.843952, lng: -97.112306 },  //Sur 18

        { lat: 18.844244, lng: -97.111609 },
        { lat: 18.843616, lng: -97.111337 },
        { lat: 18.843626, lng: -97.111310 },
        { lat: 18.844251, lng: -97.111579 },  //Sur 16

        { lat: 18.844473, lng: -97.111012 },
        { lat: 18.843691, lng: -97.110678 },
        { lat: 18.843704, lng: -97.110648 },
        { lat: 18.844479, lng: -97.110983 },  //Priv Pte 5

        { lat: 18.844811, lng: -97.110127 },
        { lat: 18.843343, lng: -97.109470 },
        { lat: 18.843361, lng: -97.109432 },
        { lat: 18.844820, lng: -97.110099 },  //Sur 12

        { lat: 18.845137, lng: -97.109298 },
        { lat: 18.843761, lng: -97.108703 },
        { lat: 18.843781, lng: -97.108664 },
        { lat: 18.845151, lng: -97.109252 },  //Sur 10

        { lat: 18.845466, lng: -97.108362 },
        { lat: 18.844222, lng: -97.107791 },
        { lat: 18.844242, lng: -97.107762 },
        { lat: 18.845478, lng: -97.108333 },  //Sur 8

        { lat: 18.845916, lng: -97.107370 },
        { lat: 18.846168, lng: -97.106626 },
        { lat: 18.846413, lng: -97.105684 },
        { lat: 18.845513, lng: -97.105367 },
        { lat: 18.845525, lng: -97.105331 },
        { lat: 18.846437, lng: -97.105645 },  //Sur 2

        { lat: 18.846996, lng: -97.103905 },
        { lat: 18.846061, lng: -97.103581 },
        { lat: 18.846078, lng: -97.103548 },
        { lat: 18.847010, lng: -97.103869 },  //Sur 3

        { lat: 18.847260, lng: -97.103027 },
        { lat: 18.846362, lng: -97.102703 },
        { lat: 18.846374, lng: -97.102666 },
        { lat: 18.847271, lng: -97.102993 },  //Sur 5

        { lat: 18.847554, lng: -97.102202 },
        { lat: 18.846696, lng: -97.101870 },
        { lat: 18.846713, lng: -97.101826 },
        { lat: 18.847570, lng: -97.102157 },  //Sur 7

        { lat: 18.847874, lng: -97.101311 },
        { lat: 18.847139, lng: -97.101038 },
        { lat: 18.847164, lng: -97.100984 },
        { lat: 18.847892, lng: -97.101264 },  //Sur 9

        { lat: 18.848168, lng: -97.100311 },
        { lat: 18.847516, lng: -97.100076 },
        { lat: 18.847536, lng: -97.100030 },
        { lat: 18.848179, lng: -97.100269 },  //Sur 11

        { lat: 18.848467, lng: -97.099333 },
        { lat: 18.848048, lng: -97.099166 },
        { lat: 18.847708, lng: -97.099080 },
        { lat: 18.847707, lng: -97.099005 },
        { lat: 18.848053, lng: -97.099112 },
        { lat: 18.848479, lng: -97.099286 },  //Sur 13

        { lat: 18.848795, lng: -97.098200 },
        { lat: 18.847681, lng: -97.097946 },
        { lat: 18.847682, lng: -97.097889 },
        { lat: 18.848809, lng: -97.098143 },  //Sur 15

        { lat: 18.849090, lng: -97.097245 },
        { lat: 18.847919, lng: -97.096898 },
        { lat: 18.847598, lng: -97.096834 },
        { lat: 18.847593, lng: -97.096798 },
        { lat: 18.847920, lng: -97.096857 },
        { lat: 18.849101, lng: -97.097202 },  //Sur 17

        { lat: 18.849453, lng: -97.096188 },
        { lat: 18.848950, lng: -97.095985 },
        { lat: 18.848463, lng: -97.095809 },
        { lat: 18.848151, lng: -97.095721 },
        { lat: 18.848037, lng: -97.095695 },
        { lat: 18.847552, lng: -97.095629 },
        { lat: 18.847560, lng: -97.095587 },
        { lat: 18.848051, lng: -97.095658 },
        { lat: 18.848369, lng: -97.095740 },
        { lat: 18.849022, lng: -97.095974 },
        { lat: 18.849468, lng: -97.096149 },  //Sur 19

        { lat: 18.849567, lng: -97.095843 },
        { lat: 18.849708, lng: -97.095307 },
        { lat: 18.849291, lng: -97.095162 },
        { lat: 18.848794, lng: -97.094999 },
        { lat: 18.848037, lng: -97.094742 },
        { lat: 18.847633, lng: -97.094542 },
        { lat: 18.847653, lng: -97.094502 },
        { lat: 18.848057, lng: -97.094701 },
        { lat: 18.849297, lng: -97.095116 },
        { lat: 18.849718, lng: -97.095264 },  //Sur 21

        { lat: 18.850177, lng: -97.094013 },
        { lat: 18.849528, lng: -97.093634 },
        { lat: 18.849219, lng: -97.093454 },
        { lat: 18.848808, lng: -97.093213 },
        { lat: 18.848446, lng: -97.093040 },  //Sur 23
    ];

    const flightPlanCoordinatesOriente5 = [
        { lat: 18.850538, lng: -97.111562 },
        { lat: 18.848564, lng: -97.110721 },
        { lat: 18.848478, lng: -97.110732 },
        { lat: 18.847779, lng: -97.110422 },
        { lat: 18.847785, lng: -97.110376 },
        { lat: 18.848499, lng: -97.110684 },

        { lat: 18.848809, lng: -97.109786 },
        { lat: 18.848118, lng: -97.109513 },
        { lat: 18.848136, lng: -97.109458 },
        { lat: 18.848818, lng: -97.109736 },  //Nte 9

        { lat: 18.849140, lng: -97.108797 },
        { lat: 18.848444, lng: -97.108528 },
        { lat: 18.848455, lng: -97.108480 },
        { lat: 18.849166, lng: -97.108755 },  //Nte 7

        { lat: 18.849528, lng: -97.107790 },
        { lat: 18.849607, lng: -97.107424 },
        { lat: 18.849792, lng: -97.107063 },
        { lat: 18.849851, lng: -97.106782 },
        { lat: 18.849063, lng: -97.106550 },
        { lat: 18.849077, lng: -97.106503 },
        { lat: 18.849872, lng: -97.106739 },  //Nte 3

        { lat: 18.850121, lng: -97.105874 },
        { lat: 18.850148, lng: -97.105836 }, //Madeero Nte

        { lat: 18.850404, lng: -97.105008 },
        { lat: 18.849854, lng: -97.104822 },
        { lat: 18.849800, lng: -97.104773 },
        { lat: 18.849767, lng: -97.104645 },
        { lat: 18.849694, lng: -97.104584 },
        { lat: 18.849645, lng: -97.104571 },
        { lat: 18.849659, lng: -97.104536 },
        { lat: 18.849737, lng: -97.104571 },
        { lat: 18.849814, lng: -97.104648 },
        { lat: 18.849841, lng: -97.104775 },
        { lat: 18.850423, lng: -97.104970 },  //Nte 2

        { lat: 18.850673, lng: -97.104149 },
        { lat: 18.849848, lng: -97.103892 },
        { lat: 18.849861, lng: -97.103856 },
        { lat: 18.850675, lng: -97.104114 },  //Nte 4

        { lat: 18.850930, lng: -97.103285 },
        { lat: 18.850114, lng: -97.103028 },
        { lat: 18.850135, lng: -97.102964 },
        { lat: 18.850958, lng: -97.103205 },  //Nte 6

        { lat: 18.851185, lng: -97.102406 },
        { lat: 18.850388, lng: -97.102163 },
        { lat: 18.850421, lng: -97.102088 },
        { lat: 18.851217, lng: -97.102325 },  //Nte 8

        { lat: 18.851492, lng: -97.101337 },
        { lat: 18.850746, lng: -97.101086 },
        { lat: 18.850760, lng: -97.101050 },
        { lat: 18.851509, lng: -97.101298 },  //Nte 10

        { lat: 18.851798, lng: -97.100263 },
        { lat: 18.851063, lng: -97.100013 },
        { lat: 18.851097, lng: -97.099935 },
        { lat: 18.851826, lng: -97.100191 },  //Nte 12

        { lat: 18.852135, lng: -97.099086 },
        { lat: 18.851443, lng: -97.098891 },
        { lat: 18.851465, lng: -97.098820 },
        { lat: 18.852152, lng: -97.099026 },  //Nte 14

        { lat: 18.852880, lng: -97.096732 },
        { lat: 18.853224, lng: -97.095747 },
        { lat: 18.853354, lng: -97.095284 },
        { lat: 18.852666, lng: -97.095072 },  //Nte 22
    ];

    const flightPlanCoordinatesOriente7 = [
        { lat: 18.850977, lng: -97.112956 },
        { lat: 18.850191, lng: -97.112862 },
        { lat: 18.850702, lng: -97.111112 },
        { lat: 18.850975, lng: -97.109954 },
        { lat: 18.850970, lng: -97.109225 },
        { lat: 18.850625, lng: -97.108454 },

        { lat: 18.850520, lng: -97.108158 },
        { lat: 18.849953, lng: -97.107180 },
        { lat: 18.849841, lng: -97.107051 },
        { lat: 18.849858, lng: -97.107011 },
        { lat: 18.849970, lng: -97.107131 },
        { lat: 18.850467, lng: -97.107979 },  //Nte 5

        { lat: 18.850715, lng: -97.107076 },
        { lat: 18.849915, lng: -97.106799 },
        { lat: 18.849922, lng: -97.106774 },
        { lat: 18.850723, lng: -97.107039 },  //Nte 3

        { lat: 18.850979, lng: -97.106159 }, //Madero Nte

        { lat: 18.851250, lng: -97.105287 },
        { lat: 18.850459, lng: -97.105026 },
        { lat: 18.850473, lng: -97.104985 },
        { lat: 18.851282, lng: -97.105257 },  //Nte 2

        { lat: 18.851525, lng: -97.104431 },
        { lat: 18.850719, lng: -97.104175 },
        { lat: 18.850733, lng: -97.104128 },
        { lat: 18.851522, lng: -97.104389 },  //Nte 4

        { lat: 18.851790, lng: -97.103552 },
        { lat: 18.850998, lng: -97.103314 },
        { lat: 18.851018, lng: -97.103224 },
        { lat: 18.851807, lng: -97.103486 },  //Nte 6

        { lat: 18.852061, lng: -97.102654 },
        { lat: 18.851236, lng: -97.102409 },
        { lat: 18.851262, lng: -97.102339 },
        { lat: 18.852078, lng: -97.102576 },  //Nte 8

        { lat: 18.852391, lng: -97.101597 },
        { lat: 18.851552, lng: -97.101349 },
        { lat: 18.851576, lng: -97.101302 },
        { lat: 18.852404, lng: -97.101552 },  //Nte 10

        { lat: 18.852732, lng: -97.100474 },
        { lat: 18.851875, lng: -97.100279 },
        { lat: 18.851911, lng: -97.100200 },
        { lat: 18.852742, lng: -97.100402 },  //Nte 12

        { lat: 18.853057, lng: -97.099434 },
        { lat: 18.852192, lng: -97.099119 },
        { lat: 18.852220, lng: -97.099036 },
        { lat: 18.853077, lng: -97.099370 },  //Nte 14

        { lat: 18.853210, lng: -97.098985 },
        { lat: 18.852344, lng: -97.098658 },
        { lat: 18.852361, lng: -97.098607 },
        { lat: 18.853231, lng: -97.098947 },  //Nte 14A

        { lat: 18.853360, lng: -97.098520 },
        { lat: 18.852492, lng: -97.098161 },
        { lat: 18.852498, lng: -97.098126 },
        { lat: 18.853381, lng: -97.098471 },  //Nte 16

        { lat: 18.853508, lng: -97.098051 },
        { lat: 18.852636, lng: -97.097711 },
        { lat: 18.852645, lng: -97.097659 },
        { lat: 18.853510, lng: -97.098001 },  //Nte 16A

        { lat: 18.853659, lng: -97.097618 },
        { lat: 18.852764, lng: -97.097265 },
        { lat: 18.852789, lng: -97.097215 },
        { lat: 18.853677, lng: -97.097584 },  //Nte 18

        { lat: 18.853845, lng: -97.097112 },
        { lat: 18.852927, lng: -97.096781 },
        { lat: 18.852956, lng: -97.096723 },
        { lat: 18.853853, lng: -97.097080 },  //Nte 18A

        { lat: 18.854047, lng: -97.096617 },
        { lat: 18.853107, lng: -97.096287 },
        { lat: 18.853114, lng: -97.096255 },
        { lat: 18.854062, lng: -97.096585 },  //Nte 20

        { lat: 18.854223, lng: -97.096145 },
        { lat: 18.853271, lng: -97.095828 },
        { lat: 18.853281, lng: -97.095786 },
        { lat: 18.854230, lng: -97.096101 },  //Nte 20A

        { lat: 18.854390, lng: -97.095657 },
        { lat: 18.853420, lng: -97.095297 },
    ];

    const flightPlanCoordinatesOriente9 = [
        { lat: 18.850948, lng: -97.112875 },
        { lat: 18.850348, lng: -97.112825 },
        { lat: 18.850851, lng: -97.110990 },
        { lat: 18.851028, lng: -97.110168 },
        { lat: 18.851010, lng: -97.109242 },
        { lat: 18.851014, lng: -97.109046 },

        { lat: 18.851258, lng: -97.108312 },
        { lat: 18.850621, lng: -97.108115 },
        { lat: 18.850588, lng: -97.108049 },
        { lat: 18.851292, lng: -97.108279 },  //Nte 5

        { lat: 18.851580, lng: -97.107369 },
        { lat: 18.850780, lng: -97.107098 },
        { lat: 18.850785, lng: -97.107057 },
        { lat: 18.851579, lng: -97.107319 },  //Nte 3

        { lat: 18.851868, lng: -97.106423 },  //Madero Nte

        { lat: 18.852121, lng: -97.105559 },
        { lat: 18.851336, lng: -97.105314 },
        { lat: 18.851354, lng: -97.105259 },
        { lat: 18.852136, lng: -97.105505 },  //Nte 2

        { lat: 18.852402, lng: -97.104674 },
        { lat: 18.851572, lng: -97.104443 },
        { lat: 18.851581, lng: -97.104418 },
        { lat: 18.852406, lng: -97.104635 },  //Nte 4

        { lat: 18.852670, lng: -97.103768 },
        { lat: 18.851876, lng: -97.103579 },
        { lat: 18.851908, lng: -97.103520 },
        { lat: 18.852685, lng: -97.103685 },  //Nte 6

        { lat: 18.852926, lng: -97.102896 },
        { lat: 18.852162, lng: -97.102679 },
        { lat: 18.852176, lng: -97.102599 },
        { lat: 18.852961, lng: -97.102819 },  //Nte 8

        { lat: 18.853301, lng: -97.101847 },
        { lat: 18.852457, lng: -97.101618 },
        { lat: 18.852484, lng: -97.101579 },
        { lat: 18.853317, lng: -97.101804 },  //Nte 10

        { lat: 18.853645, lng: -97.100879 },
        { lat: 18.852797, lng: -97.100514 },
        { lat: 18.852857, lng: -97.100454 },
        { lat: 18.853682, lng: -97.100820 },  //Nte 12

        { lat: 18.853856, lng: -97.100360 },
        { lat: 18.853244, lng: -97.100080 },
        { lat: 18.853274, lng: -97.100048 },
        { lat: 18.853866, lng: -97.100327 },  //Nte 12A

        { lat: 18.854035, lng: -97.099812 },
        { lat: 18.853673, lng: -97.099660 },
        { lat: 18.853730, lng: -97.099606 },
        { lat: 18.854057, lng: -97.099757 },  //Nte 14

        { lat: 18.854351, lng: -97.098931 },
        { lat: 18.854245, lng: -97.098869 },
        { lat: 18.853448, lng: -97.098558 },
        { lat: 18.853472, lng: -97.098515 },
        { lat: 18.854284, lng: -97.098832 },
        { lat: 18.854373, lng: -97.098907 },  //Nte 16

        { lat: 18.854519, lng: -97.098479 },
        { lat: 18.853592, lng: -97.098095 },
        { lat: 18.853615, lng: -97.098053 },
        { lat: 18.854533, lng: -97.098432 },  //Nte 16A

        { lat: 18.854681, lng: -97.098018 },
        { lat: 18.853757, lng: -97.097677 },
        { lat: 18.853776, lng: -97.097614 },
        { lat: 18.854693, lng: -97.097981 },  //Nte 18

        { lat: 18.854881, lng: -97.097507 },
        { lat: 18.853923, lng: -97.097169 },
        { lat: 18.853951, lng: -97.097114 },
        { lat: 18.854891, lng: -97.097468 },  //Nte 18A

        { lat: 18.855063, lng: -97.096985 },
        { lat: 18.854127, lng: -97.096667 },
        { lat: 18.854145, lng: -97.096614 },
        { lat: 18.855080, lng: -97.096946 },  //Nte 20

        { lat: 18.855240, lng: -97.096470 },
        { lat: 18.854307, lng: -97.096178 },
        { lat: 18.854319, lng: -97.096138 },
        { lat: 18.855265, lng: -97.096433 },  //Nte 20A

        { lat: 18.855422, lng: -97.096004 },
        { lat: 18.854480, lng: -97.095675 },  //Nte 22
    ];

    const flightPlanCoordinatesCalleReal1 = [
        { lat: 18.839478, lng: -97.116138 },
        { lat: 18.839533, lng: -97.115822 },
        { lat: 18.839601, lng: -97.115688 },
        { lat: 18.841646, lng: -97.112572 },
        { lat: 18.841793, lng: -97.112272 },
        { lat: 18.842336, lng: -97.111438 },
        { lat: 18.842909, lng: -97.110292 },
        { lat: 18.843316, lng: -97.109417 },
        { lat: 18.843706, lng: -97.108703 },
        { lat: 18.844181, lng: -97.107741 },
        { lat: 18.844477, lng: -97.107164 },
        { lat: 18.844726, lng: -97.106687 },
        { lat: 18.845118, lng: -97.106008 },
        { lat: 18.845484, lng: -97.105325 },
        { lat: 18.845697, lng: -97.104516 },
        { lat: 18.846034, lng: -97.103546 },
        { lat: 18.846339, lng: -97.102637 },
        { lat: 18.846668, lng: -97.101815 },
        { lat: 18.847093, lng: -97.100995 },
        { lat: 18.847483, lng: -97.100009 },
        { lat: 18.847644, lng: -97.099591 },
        { lat: 18.847674, lng: -97.099374 },
        { lat: 18.847642, lng: -97.098981 },
        { lat: 18.847635, lng: -97.097734 },
        { lat: 18.847543, lng: -97.096770 },
        { lat: 18.847481, lng: -97.095559 },
        { lat: 18.847502, lng: -97.095085 },
        { lat: 18.847570, lng: -97.094651 },
        { lat: 18.847583, lng: -97.094512 },
        { lat: 18.847806, lng: -97.094018 },
        { lat: 18.848409, lng: -97.093030 },
        { lat: 18.848645, lng: -97.092254 },
        { lat: 18.848890, lng: -97.091390 },
        { lat: 18.849407, lng: -97.089554 },
        { lat: 18.849574, lng: -97.088621 },
        { lat: 18.849663, lng: -97.088237 },
        { lat: 18.849758, lng: -97.087640 },
        { lat: 18.850035, lng: -97.086127 },
        { lat: 18.850558, lng: -97.084559 },
        { lat: 18.850849, lng: -97.083633 },
        { lat: 18.851625, lng: -97.081303 },
    ];

    const flightPlanCoordinatesCalleReal2 = [
        { lat: 18.839352, lng: -97.116104 },
        { lat: 18.839466, lng: -97.115738 },
        { lat: 18.840369, lng: -97.114324 },
        { lat: 18.840819, lng: -97.113523 },
        { lat: 18.840933, lng: -97.113290 },
        { lat: 18.842233, lng: -97.111429 },
        { lat: 18.842749, lng: -97.110328 },
        { lat: 18.843221, lng: -97.109395 },
        { lat: 18.843608, lng: -97.108605 },
        { lat: 18.844067, lng: -97.107711 },
        { lat: 18.844360, lng: -97.107188 },
        { lat: 18.844778, lng: -97.106410 },
        { lat: 18.845411, lng: -97.105296 },
        { lat: 18.845605, lng: -97.104418 },
        { lat: 18.846237, lng: -97.102623 },
        { lat: 18.846589, lng: -97.101798 },
        { lat: 18.846977, lng: -97.100956 },
        { lat: 18.847582, lng: -97.099423 },
        { lat: 18.847548, lng: -97.099017 },
        { lat: 18.847528, lng: -97.097550 },
        { lat: 18.847444, lng: -97.096820 },
        { lat: 18.847392, lng: -97.095599 },
        { lat: 18.847398, lng: -97.095010 },
        { lat: 18.847483, lng: -97.094439 },
        { lat: 18.848255, lng: -97.092986 },
        { lat: 18.848509, lng: -97.092215 },
        { lat: 18.848775, lng: -97.091355 },
        { lat: 18.849005, lng: -97.090500 },
        { lat: 18.849249, lng: -97.089514 },
        { lat: 18.849466, lng: -97.088606 },
        { lat: 18.849624, lng: -97.087650 },
        { lat: 18.849801, lng: -97.086708 },
        { lat: 18.849920, lng: -97.086118 },
        { lat: 18.850438, lng: -97.084549 },
        { lat: 18.850677, lng: -97.083742 },
        { lat: 18.851444, lng: -97.081420 },
    ];

    const lineSymbol = {
        path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
    };

    const flightPathColon = new google.maps.Polyline({
        path: flightPlanCoordinatesColon,
        geodesic: true,
        strokeColor: "#ff0000",
        strokeOpacity: 1.0,
        strokeWeight: 3,
        icons: [
            {
                icon: lineSymbol,
                offset: "100%",
                repeat: '100px'
            },
        ],
    });
    flightPathColon.setMap(map);

    const flightPathOriente2 = new google.maps.Polyline({
        path: flightPlanCoordinatesOriente2,
        geodesic: true,
        strokeColor: "#008bfd",
        strokeOpacity: 1.0,
        strokeWeight: 3,
        icons: [
            {
                icon: lineSymbol,
                offset: "100%",
                repeat: '100px'
            },
        ],
    });
    flightPathOriente2.setMap(map);

    const flightPathOriente3 = new google.maps.Polyline({
        path: flightPlanCoordinatesOriente3,
        geodesic: true,
        strokeColor: "#fffb00",
        strokeOpacity: 1.0,
        strokeWeight: 3,
        icons: [
            {
                icon: lineSymbol,
                offset: "100%",
                repeat: '100px'
            },
        ],
    });
    flightPathOriente3.setMap(map);

    const flightPathOriente4 = new google.maps.Polyline({
        path: flightPlanCoordinatesOriente4,
        geodesic: true,
        strokeColor: "#004ca3",
        strokeOpacity: 1.0,
        strokeWeight: 3,
        icons: [
            {
                icon: lineSymbol,
                offset: "100%",
                repeat: '100px'
            },
        ],
    });
    flightPathOriente4.setMap(map);

    const flightPathOriente5 = new google.maps.Polyline({
        path: flightPlanCoordinatesOriente5,
        geodesic: true,
        strokeColor: "#d400ff",
        strokeOpacity: 1.0,
        strokeWeight: 3,
        icons: [
            {
                icon: lineSymbol,
                offset: "100%",
                repeat: '100px'
            },
        ],
    });
    flightPathOriente5.setMap(map);

    const flightPathOriente7 = new google.maps.Polyline({
        path: flightPlanCoordinatesOriente7,
        geodesic: true,
        strokeColor: "#8b5815",
        strokeOpacity: 1.0,
        strokeWeight: 3,
        icons: [
            {
                icon: lineSymbol,
                offset: "100%",
                repeat: '100px'
            },
        ],
    });
    flightPathOriente7.setMap(map);

    const flightPathOriente9 = new google.maps.Polyline({
        path: flightPlanCoordinatesOriente9,
        geodesic: true,
        strokeColor: "#008600",
        strokeOpacity: 1.0,
        strokeWeight: 3,
        icons: [
            {
                icon: lineSymbol,
                offset: "100%",
                repeat: '100px'
            },
        ],
    });
    flightPathOriente9.setMap(map);

    const flightPathCalleReal1 = new google.maps.Polyline({
        path: flightPlanCoordinatesCalleReal1,
        geodesic: true,
        strokeColor: "#ffffff",
        strokeOpacity: 1.0,
        strokeWeight: 3,
        icons: [
            {
                icon: lineSymbol,
                offset: "100%",
                repeat: '100px'
            },
        ],
    });
    flightPathCalleReal1.setMap(map);

    const flightPathCalleReal2 = new google.maps.Polyline({
        path: flightPlanCoordinatesCalleReal2,
        geodesic: true,
        strokeColor: "#000000",
        strokeOpacity: 1.0,
        strokeWeight: 3,
        icons: [
            {
                icon: lineSymbol,
                offset: "100%",
                repeat: '100px'
            },
        ],
    });
    flightPathCalleReal2.setMap(map);

}

window.initMap = initMap;