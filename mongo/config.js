// @NOTE: MongoDB-JS native methods are documented here:
// https://docs.mongodb.com/manual/reference/method/js-native/

let rsStat = rs.status();

if (!rsStat.members) {
    rs.initiate({
        _id : '$replSet',
        members: [
            { _id: 0, host: 'localhost:$port', priority: 3 },
        ]
    });
} else quit()

function createUsers () {
    db.createUser({ user: 'dba', pwd: 'dba',
        roles: [ 'dbAdmin', 'userAdmin', 'clusterAdmin' ]
    });
    db.auth('dba', 'dba');
    db.createUser({ user: 'dbu', pwd: 'dbu',
        roles: [ 'root', 'readWriteAnyDatabase' ]
    });
}

rsStat = rs.status();
while ((Array.isArray(rsStat.members) && rsStat.members.length === 1 &&
        rsStat.members[0].name === 'localhost:$port' &&
        rsStat.members[0].stateStr === 'PRIMARY') === false) {
    sleep(1000);
    rsStat = rs.status();
    continue;
};

createUsers();