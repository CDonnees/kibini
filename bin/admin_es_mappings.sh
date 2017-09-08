#! /bin/bash

rm /home/kibini/kibini_prod/etc/es_mappings.yaml

for index in action_coop action_culturelle adherents adherents2015 adherents_synth adherents_tout catalogue documents_synth eliminations entrees freq_etude frequentation inscrits_synth_carte items notices_auth prets prets2 reservations rfid syntheses titres web web2 webkiosk

do
    curl -XGET localhost:9200/$index/_mapping > /home/kibini/kibini_prod/etc/map.json
    catmandu convert JSON to YAML < /home/kibini/kibini_prod/etc/map.json >> /home/kibini/kibini_prod/etc/es_mappings.yaml
done

rm /home/kibini/kibini_prod/etc/map.json
