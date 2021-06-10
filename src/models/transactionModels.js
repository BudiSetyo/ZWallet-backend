const db = require("../database/dbMysql");

const topUp = (id, amount) => {
  return new Promise((resolve, reject) => {
    const getPrevBalance =
      "SELECT balance_nominal FROM balances WHERE user_id = ?";
    db.query(getPrevBalance, id, (error, result) => {
      if (error) {
        console.log(error);
        return reject(error);
      } else {
        console.log(result.length);
        const isExist = result.length > 0;
        const newBalance = isExist
          ? result[0].balance_nominal + Number(amount)
          : Number(amount);

        if (isExist) {
          const data = {
            balance_nominal: newBalance
          };
          const queryString = "UPDATE balances SET ? WHERE user_id = ?";
          db.query(queryString, [data, id], (error, result) => {
            if (error) {
              return reject(error);
            } else {
              console.log("Are u here?");
              const historyData = {
                sender_id: id,
                receiver_id: id,
                transaction_nominal: amount,
                type: "top up"
              };
              const addHistory = "INSERT INTO transactions SET ?";
              db.query(addHistory, historyData, (error, result) => {
                if (error) {
                  return reject(error);
                } else {
                  return resolve(result);
                }
              });
            }
          });
        } else {
          const data = {
            user_id: id,
            balance_nominal: newBalance
          };
          const queryString = "INSERT INTO balances SET ?";
          db.query(queryString, [data], (error, result) => {
            console.log("Are u here2?");

            if (error) {
              return reject(error);
            } else {
              const historyData = {
                sender_id: id,
                receiver_id: id,
                transaction_nominal: amount,
                type: "top up"
              };
              const addHistory = "INSERT INTO transactions SET ?";
              db.query(addHistory, historyData, (error, result) => {
                if (error) {
                  return reject(error);
                } else {
                  return resolve(result);
                }
              });
            }
          });
        }
      }
    });
  });
};

const transfer = (sender, receiver, amount, note) => {
  let senderBalance, receiverBalance;

  //   Check sender balance
  const getPrevBalance =
    "SELECT balance_nominal FROM balances WHERE user_id = ?";
  return new Promise((resolve, reject) => {
    db.query(getPrevBalance, sender, (error, result) => {
      if (error) {
        return reject(error);
      } else if (result.length > 0) {
        senderBalance = Number(result[0].balance_nominal);
        // Add to transaction history table
        if (senderBalance > amount) {
          const dataSender = {
            sender_id: sender,
            receiver_id: receiver,
            transaction_nominal: amount,
            type: "credit",
            note: note
          };

          const dataReceiver = {
            sender_id: sender,
            receiver_id: receiver,
            transaction_nominal: amount,
            type: "debit",
            note: note
          };

          const addTransaction = "INSERT INTO transactions SET ?";
          db.query(addTransaction, dataSender, (error, result) => {
            if (error) {
              return reject(error);
            } else {
              db.query(addTransaction, dataReceiver, (error, result) => {
                if (error) {
                  return reject(error);
                } else {
                  // Reducing sender balance
                  const data = {
                    balance_nominal: senderBalance - Number(amount)
                  };
                  const updateBalance =
                    "UPDATE balances SET ? WHERE user_id = ?";
                  db.query(updateBalance, [data, sender], (error, result) => {
                    if (error) {
                      return reject(error);
                    } else {
                      console.log(data.balance_nominal);
                      // Add balance to receiver
                      db.query(getPrevBalance, receiver, (error, result) => {
                        if (error) {
                          return reject(error);
                        } else if (result.length > 0) {
                          receiverBalance = Number(result[0].balance_nominal);
                          const data = {
                            balance_nominal: receiverBalance + Number(amount)
                          };

                          db.query(
                            updateBalance,
                            [data, receiver],
                            (error, result) => {
                              if (error) {
                                return reject(error);
                              } else {
                                resolve(result);
                              }
                            }
                          );
                        } else {
                          const data = {
                            user_id: receiver,
                            balance_nominal: amount
                          };
                          const queryString = "INSERT INTO balances SET ?";
                          db.query(queryString, [data], (error, result) => {
                            if (error) {
                              return reject(error);
                            } else {
                              resolve(result);
                            }
                          });
                        }
                      });
                    }
                  });
                }
              });
            }
          });
        } else {
          return resolve({ conflict: "Not enough balance" });
        }
      } else {
        return resolve({ conflict: "Not enough balance" });
      }
    });
  });
};

const history = (id, pages) => {
  const qs = "SELECT * FROM transactions WHERE sender_id = ? OR receiver_id = ?";
  // SELECT * FROM transactions WHERE (sender_id =2 OR receiver_id = 2) AND transaction_nominal>10000 AND type='top up' AND DATE(created_at) BETWEEN unix_timestamp('2021-06-09') AND unix_timestamp('2021-06-11') ORDER BY id DESC

  const paginate = " LIMIT ? OFFSET ?";

  const fullQuery = qs + paginate;

  const limit = 5;
  const page = Number(pages) || 1;
  const offset = (page - 1) * limit;

  return new Promise((resolve, reject) => {
    db.query(fullQuery, [id, id, limit, offset], (error, result) => {
      if (error) {
        return reject(error);
      } else {
        const qsCount = "SELECT COUNT(*) AS count FROM(" + qs + ") as count";
        db.query(qsCount, [id, id], (error, data) => {
          if (error) {
            return reject(error);
          } else {
            const { count } = data[0];
            const finalResult = {
              result,
              count,
              page,
              limit
            };
            resolve(finalResult);
          }
        });
      }
    });
  });
};
module.exports = {
  topUp,
  transfer,
  history
};