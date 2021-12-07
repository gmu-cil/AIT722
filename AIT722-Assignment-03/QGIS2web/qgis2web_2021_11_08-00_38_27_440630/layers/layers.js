var wms_layers = [];

var format_ZipCodes_0 = new ol.format.GeoJSON();
var features_ZipCodes_0 = format_ZipCodes_0.readFeatures(json_ZipCodes_0, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_ZipCodes_0 = new ol.source.Vector({
    attributions: ' ',
});
jsonSource_ZipCodes_0.addFeatures(features_ZipCodes_0);
var lyr_ZipCodes_0 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_ZipCodes_0, 
                style: style_ZipCodes_0,
                interactive: true,
                title: '<img src="styles/legend/ZipCodes_0.png" /> Zip Codes'
            });
var format_Count_1 = new ol.format.GeoJSON();
var features_Count_1 = format_Count_1.readFeatures(json_Count_1, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Count_1 = new ol.source.Vector({
    attributions: ' ',
});
jsonSource_Count_1.addFeatures(features_Count_1);
var lyr_Count_1 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Count_1, 
                style: style_Count_1,
                interactive: true,
    title: 'Count<br />\
    <img src="styles/legend/Count_1_0.png" /> 0<br />\
    <img src="styles/legend/Count_1_1.png" /> 1<br />\
    <img src="styles/legend/Count_1_2.png" /> 2<br />\
    <img src="styles/legend/Count_1_3.png" /> 3<br />\
    <img src="styles/legend/Count_1_4.png" /> 4<br />\
    <img src="styles/legend/Count_1_5.png" /> 5<br />\
    <img src="styles/legend/Count_1_6.png" /> 6<br />\
    <img src="styles/legend/Count_1_7.png" /> 7<br />\
    <img src="styles/legend/Count_1_8.png" /> 8<br />\
    <img src="styles/legend/Count_1_9.png" /> 10<br />\
    <img src="styles/legend/Count_1_10.png" /> <br />'
        });
var format_Schools_2 = new ol.format.GeoJSON();
var features_Schools_2 = format_Schools_2.readFeatures(json_Schools_2, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Schools_2 = new ol.source.Vector({
    attributions: ' ',
});
jsonSource_Schools_2.addFeatures(features_Schools_2);
var lyr_Schools_2 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Schools_2, 
                style: style_Schools_2,
                interactive: true,
                title: '<img src="styles/legend/Schools_2.png" /> Schools'
            });

lyr_ZipCodes_0.setVisible(true);lyr_Count_1.setVisible(true);lyr_Schools_2.setVisible(true);
var layersList = [lyr_ZipCodes_0,lyr_Count_1,lyr_Schools_2];
lyr_ZipCodes_0.set('fieldAliases', {'OBJECTID_12': 'OBJECTID_12', 'ZIPCODE': 'ZIPCODE', 'ZIPCITY': 'ZIPCITY', 'CreationDate': 'CreationDate', 'Creator': 'Creator', 'EditDate': 'EditDate', 'Editor': 'Editor', 'Shape__Area': 'Shape__Area', 'Shape__Length': 'Shape__Length', });
lyr_Count_1.set('fieldAliases', {'OBJECTID_12': 'OBJECTID_12', 'ZIPCODE': 'ZIPCODE', 'ZIPCITY': 'ZIPCITY', 'CreationDate': 'CreationDate', 'Creator': 'Creator', 'EditDate': 'EditDate', 'Editor': 'Editor', 'Shape__Area': 'Shape__Area', 'Shape__Length': 'Shape__Length', 'NUMPOINTS': 'NUMPOINTS', });
lyr_Schools_2.set('fieldAliases', {'X': 'X', 'Y': 'Y', 'OBJECTID': 'OBJECTID', 'SCHOOL_NAME': 'SCHOOL_NAME', 'SCHOOL_TYPE': 'SCHOOL_TYPE', 'TYPE_DESC': 'TYPE_DESC', 'GRADES': 'GRADES', 'ADDRESS': 'ADDRESS', 'CITY': 'CITY', 'ZIP': 'ZIP', 'WEB_ADDRESS': 'WEB_ADDRESS', 'PHONE': 'PHONE', 'REGION': 'REGION', 'SCH_YR': 'SCH_YR', 'CreationDate': 'CreationDate', 'Creator': 'Creator', 'EditDate': 'EditDate', 'Editor': 'Editor', });
lyr_ZipCodes_0.set('fieldImages', {'OBJECTID_12': 'Range', 'ZIPCODE': 'Range', 'ZIPCITY': 'TextEdit', 'CreationDate': 'DateTime', 'Creator': 'TextEdit', 'EditDate': 'DateTime', 'Editor': 'TextEdit', 'Shape__Area': 'TextEdit', 'Shape__Length': 'TextEdit', });
lyr_Count_1.set('fieldImages', {'OBJECTID_12': 'Range', 'ZIPCODE': 'Range', 'ZIPCITY': 'TextEdit', 'CreationDate': 'DateTime', 'Creator': 'TextEdit', 'EditDate': 'DateTime', 'Editor': 'TextEdit', 'Shape__Area': 'TextEdit', 'Shape__Length': 'TextEdit', 'NUMPOINTS': 'TextEdit', });
lyr_Schools_2.set('fieldImages', {'X': 'TextEdit', 'Y': 'TextEdit', 'OBJECTID': 'Range', 'SCHOOL_NAME': 'TextEdit', 'SCHOOL_TYPE': 'TextEdit', 'TYPE_DESC': 'TextEdit', 'GRADES': 'TextEdit', 'ADDRESS': 'TextEdit', 'CITY': 'TextEdit', 'ZIP': 'Range', 'WEB_ADDRESS': 'TextEdit', 'PHONE': 'TextEdit', 'REGION': 'Range', 'SCH_YR': 'TextEdit', 'CreationDate': 'DateTime', 'Creator': 'TextEdit', 'EditDate': 'DateTime', 'Editor': 'TextEdit', });
lyr_ZipCodes_0.set('fieldLabels', {'OBJECTID_12': 'no label', 'ZIPCODE': 'no label', 'ZIPCITY': 'no label', 'CreationDate': 'no label', 'Creator': 'no label', 'EditDate': 'no label', 'Editor': 'no label', 'Shape__Area': 'no label', 'Shape__Length': 'no label', });
lyr_Count_1.set('fieldLabels', {'OBJECTID_12': 'no label', 'ZIPCODE': 'no label', 'ZIPCITY': 'no label', 'CreationDate': 'no label', 'Creator': 'no label', 'EditDate': 'no label', 'Editor': 'no label', 'Shape__Area': 'no label', 'Shape__Length': 'no label', 'NUMPOINTS': 'no label', });
lyr_Schools_2.set('fieldLabels', {'X': 'no label', 'Y': 'no label', 'OBJECTID': 'no label', 'SCHOOL_NAME': 'no label', 'SCHOOL_TYPE': 'no label', 'TYPE_DESC': 'no label', 'GRADES': 'no label', 'ADDRESS': 'no label', 'CITY': 'no label', 'ZIP': 'no label', 'WEB_ADDRESS': 'no label', 'PHONE': 'no label', 'REGION': 'no label', 'SCH_YR': 'no label', 'CreationDate': 'no label', 'Creator': 'no label', 'EditDate': 'no label', 'Editor': 'no label', });
lyr_Schools_2.on('precompose', function(evt) {
    evt.context.globalCompositeOperation = 'normal';
});