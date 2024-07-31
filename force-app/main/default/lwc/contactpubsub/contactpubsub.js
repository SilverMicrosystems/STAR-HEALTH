const store={};

const subscribe = (eventName,callback) =>{
        if(!store[eventName]){
        store[eventName] = new Set();
        }
        store[eventName].add(callback);
};

const unsubscribe = (eventName,callback) =>{
        if(store[eventName]){
        store[eventName].delete(callback);
        }
};

const publish = (eventName, payLoad) =>{
        if(store[eventName]){
        store[eventName].forEach(callback => {
            try{
            callback(payLoad);
            }
            catch(error){
            console.log(error);
            }
});
}
};

export default{
        subscribe,
        unsubscribe,
        publish

}
