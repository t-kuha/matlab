%% Local Binary Pattern

function ret = lbpfun(x)
% colfilt() ���g�p����ꍇ�ɂ͗�x�N�g���œ����Ă��Ȃ��ꍇ������̂Œ��ӂ���
% | 128  64  32 |
% |   1   0  16 |
% |   2   4   8 |

% fprintf('%d x %d\n', size(x,1), size(x,2));
bp_ = [128, 1, 2, 64, 0, 4, 32, 16, 8]/255;

ret = bp_*((x - repmat(x(5,:), size(x,1), 1)) >= 0);
