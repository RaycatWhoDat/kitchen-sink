var createQueue = () => {
    const queue = [];

    return {
        enqueue(item) {
            return queue.push(item);
        },
        dequeue() {
            if (!queue.length) return undefined;
            return queue.shift();
        },
        peek() {
            return queue[0];
        },
        contents() {
            return queue;
        },
        isEmpty() {
            return !queue.length;
        }
    }
};

var q = createQueue();

q.enqueue('Make an important lesson');
q.enqueue('Kill Your Brain');
q.enqueue('Send me an email');

console.log(q.length());
