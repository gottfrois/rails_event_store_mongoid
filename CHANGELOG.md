* 0.15.1

Relax mongoid version deps

* 0.15.0

Mongo ids are generated client side which is not guarante to be monotonic if
multiple records are created at the same time.

To maintain correct event order, we rely on a server side generated BSON timestamp.
https://docs.mongodb.com/manual/reference/bson-types/#timestamps
