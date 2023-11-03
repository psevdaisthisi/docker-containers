// @NOTE: MongoDB-JS native methods are documented here:
// https://docs.mongodb.com/manual/reference/method/js-native/

let rsStat = null
try { rsStat = rs.status(); }
catch (err) {}

if (!rsStat || !rsStat?.members) {
	rs.initiate({
        _id : '$replSet',
        members: [
            { _id: 0, host: 'localhost:$port', priority: 3 },
        ]
    });
}
else quit()

// Wait some time for the Replica Set to be available
sleep(2000);

db.createUser({ user: 'dba', pwd: 'dba',
	roles: [ 'dbAdmin', 'userAdmin', 'clusterAdmin' ]
});

db.auth('dba', 'dba');
db.createUser({ user: 'dbu', pwd: 'dbu',
	roles: [ 'root', 'readWriteAnyDatabase' ]
});